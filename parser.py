#!/bin/python3

"""
   Copyright 2022 Federico Reghenzani

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
"""

import pyparsing as pp
import sys

###################################################################################################
# Parser token definitions
###################################################################################################

# First of all, the parser should not ignore line ends
pp.ParserElement.setDefaultWhitespaceChars(' \t')

## Numbers
# They can have a +, a -, or be hex
token_number_hex = pp.Literal("0x") + pp.Word(pp.hexnums)
token_number = pp.Combine(pp.Optional(pp.Char('-') ^ pp.Char('+')) + (pp.Word(pp.nums) ^ token_number_hex))

## Functions
token_identifier = pp.pyparsing_common.identifier   # This is a standard identifier for Python, should be ok also for C
# Arguments can be a sequence of types (like unsigned int **) with an arbitrary number of *
token_argument = pp.Combine((token_identifier)[...] + pp.Char('*')[...], adjacent=False, joinString=" ")
token_arguments = pp.Optional(token_argument) ^ (token_argument + (pp.Suppress(pp.Char(',')) + token_argument)[...])
token_function_full = pp.Group(token_identifier + pp.Suppress("(") + token_arguments + pp.Suppress(")"))
token_functions = token_function_full + pp.Suppress(pp.Char(':'))   # Function line declaration

## Labels
# A label can be in one of the following formats:
# global_label:
# .local_label:
# global_label.something:
# global_label.1234:
token_label_name = pp.Combine(pp.Optional(".") + pp.Optional(pp.Word(pp.nums)) + token_identifier + pp.Optional("." + pp.Optional(pp.Word(pp.nums)) + pp.Optional(token_identifier)))("name")
token_labels = token_label_name + pp.Suppress(":")

## Instructions
# For instructions the main difficulty is matching all the parameters type:
# - Numbers
# - Labels
# - Relocation like %h1(abc)
# - A numeric register
# - A named register
# - Any offset of the previous (including %h1(abc)(a3))
# Instruction names can also contain dots
token_instruction_parameter_num = token_number
token_instruction_parameter_label = token_label_name
token_instruction_parameter_relocation = pp.Group(pp.Combine(pp.Char('%')+ pp.pyparsing_common.identifier) + pp.Suppress("(") + (pp.pyparsing_common.identifier ^ token_instruction_parameter_label) + pp.Suppress(")"))
token_instruction_parameter_register_num = (pp.Char('x') ^ pp.Char('axts') ^ pp.Literal('fa')) + token_number
token_instruction_parameter_register_oth = (pp.Literal('zero') ^ pp.Literal('ra') ^ pp.Literal('sp') ^ pp.Literal('gp') ^ pp.Literal('tp') ^ pp.Literal('fp') ^ pp.Literal('pc'))
token_instruction_parameter_all = pp.pyparsing_common.identifier ^ token_instruction_parameter_num ^ token_instruction_parameter_label ^ token_instruction_parameter_relocation ^ token_instruction_parameter_register_num ^ token_instruction_parameter_register_oth
token_instruction_parameter_offset = pp.Group(token_instruction_parameter_all + pp.Suppress("(") + token_instruction_parameter_all + pp.Suppress(")"))
token_instruction_parameter_fun = token_function_full
token_instruction_parameter = token_instruction_parameter_all ^ token_instruction_parameter_offset ^ token_instruction_parameter_fun
token_instruction_name = pp.Combine(pp.Word(pp.alphanums) + (pp.Char('.') + pp.Word(pp.alphanums))[...])
token_instructions = token_instruction_name("name") + pp.Optional(token_instruction_parameter("param") + (pp.Suppress(",")+token_instruction_parameter("param"))[...])

## Pseudo OPS
# There are several pseudo ops with different syntax. Probably some are missing
token_pseudoops_arg_sym = pp.Combine(pp.Optional('.') + token_identifier + pp.Optional(pp.Char(',') + token_number + pp.Char(',') + token_number) + pp.Optional("," + token_identifier), adjacent=False, joinString=" ")
token_pseudoops_arg_str = pp.QuotedString('"')
token_pseudoops_arg_lbl = pp.Char('.')+ pp.pyparsing_common.identifier
token_pseudoops_arg = token_number ^ token_pseudoops_arg_sym ^ token_pseudoops_arg_str ^ token_pseudoops_arg_lbl
token_pseudoops = pp.Suppress('.') + (pp.Word(pp.nums) ^ pp.pyparsing_common.identifier) + token_pseudoops_arg

## Line
# Define the new line constant
NL = pp.Suppress(pp.LineEnd())

# General line format
token_all = pp.Group(token_functions("function") ^ token_labels("label") ^ token_instructions("instruction") ^ token_pseudoops("pseudop")) + NL
lines_all = token_all[1,...]   # Whole file format

###################################################################################################
# Parser config and run definitions
###################################################################################################

lines_all.ignore("#" + pp.restOfLine)   # Ignore comments starting with #

if len(sys.argv) < 2:
    print("Usage: python parser.py file_name.s")
    sys.exit()

parsed = lines_all.parseFile(sys.argv[1], parseAll=True)
print(parsed.dump())

