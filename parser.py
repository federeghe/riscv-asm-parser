#!/bin/python3
import pyparsing as pp

pp.ParserElement.setDefaultWhitespaceChars(' \t') 

# Numbers
token_number = pp.Combine(pp.Optional(pp.Char('-')) + (pp.Word(pp.nums) ^ (pp.Literal("0x") + pp.Word(pp.hexnums))))

# Functions
token_identifier = pp.pyparsing_common.identifier 
token_argument = pp.Combine(token_identifier + pp.Char('*')[...])
token_arguments = pp.Optional(token_argument) ^ (token_argument + (pp.Suppress(pp.Char(',')) + token_argument)[...])
token_functions = pp.Group(token_identifier + pp.Optional(pp.Suppress("(") + token_arguments + pp.Suppress(")")) + pp.Suppress(pp.Char(':')))

# Labels
token_label_name = pp.Combine(pp.Optional(".") + pp.Optional(pp.Word(pp.nums)) + token_identifier + pp.Optional("." + pp.Optional(pp.Word(pp.nums)) + pp.Optional(token_identifier)))("name")
token_labels = token_label_name + pp.Suppress(":")

# Instructions
token_instruction_parameter_num = token_number
token_instruction_parameter_label = token_label_name
token_instruction_parameter_relocation = pp.Group(pp.Combine(pp.Char('%')+ pp.pyparsing_common.identifier) + pp.Suppress("(") + (pp.pyparsing_common.identifier ^ token_instruction_parameter_label) + pp.Suppress(")"))
token_instruction_parameter_register_num = (pp.Char('x') ^ pp.Char('axts') ^ pp.Literal('fa')) + token_number
token_instruction_parameter_register_oth = (pp.Literal('zero') ^ pp.Literal('ra') ^ pp.Literal('sp') ^ pp.Literal('gp') ^ pp.Literal('tp') ^ pp.Literal('fp') ^ pp.Literal('pc'))
token_instruction_parameter_all = pp.pyparsing_common.identifier ^ token_instruction_parameter_num ^ token_instruction_parameter_label ^ token_instruction_parameter_relocation ^ token_instruction_parameter_register_num ^ token_instruction_parameter_register_oth
token_instruction_parameter_offset = pp.Group(token_instruction_parameter_all + pp.Suppress("(") + token_instruction_parameter_all + pp.Suppress(")"))

token_instruction_parameter = token_instruction_parameter_all ^ token_instruction_parameter_offset
token_instruction_name = pp.Combine(pp.Word(pp.alphanums) + (pp.Char('.') + pp.Word(pp.alphanums))[...])
token_instructions = token_instruction_name("name") + pp.Optional(token_instruction_parameter("param") + (pp.Suppress(",")+token_instruction_parameter("param"))[...])

# Pseudo OPS
token_pseudoops_arg_sym = pp.Combine(token_identifier + pp.Optional(pp.Char(',') + token_number + pp.Char(',') + token_number) + pp.Optional("," + token_identifier))
token_pseudoops_arg_str = pp.QuotedString('"')
token_pseudoops_arg_lbl = pp.Char('.')+ pp.pyparsing_common.identifier
token_pseudoops_arg = token_number ^ token_pseudoops_arg_sym ^ token_pseudoops_arg_str ^ token_pseudoops_arg_lbl
token_pseudoops = pp.Suppress('.') + (pp.Word(pp.nums) ^ pp.pyparsing_common.identifier) + token_pseudoops_arg

NL = pp.Suppress(pp.LineEnd())

token_all = pp.Group(token_functions("function") ^ token_labels("label") ^ token_instructions("instruction") ^ token_pseudoops("pseudop")) + NL
lines_all = token_all[1,...] 

lines_all.ignore("#" + pp.restOfLine) 
parsed = lines_all.parseFile("examples/riscv32.s", parseAll=True)
print(parsed.dump())

