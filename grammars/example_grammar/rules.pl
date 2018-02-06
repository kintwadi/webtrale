sentence_rule rule 
    (phrase,
        comps: [],
        dtrs: [One, Two],
        syntax: (syntax,
            head: s))
    ===>
    cat> (word,One,
            comps: [],
            syntax: (syntax,
                head: (noun,
                    case: nom))),
    cat> (word,Two,
            comps: [],
            syntax: (syntax,
                head: (verb,
                    vform: fin))).

noun_verbphrase_rule2 rule 
    (phrase,
        comps: [],
        dtrs: [One, Two, Three],
        syntax: (syntax,
            head: (verb,
                vform: fin)))
    ===>
    cat> (word,One,
            comps: [(noun), (noun)],
            syntax: (syntax,
                head: (verb,
                    vform: fin))),
    cat> (word,Two,
            comps: [],
            syntax: (syntax,
                head: (noun))),
    cat> (word,Three,
            comps: [],
            syntax: (syntax,
                head: (noun))).

verbphrase_rule rule 
    (phrase,
        comps: [],
        dtrs: [One, Two],
        syntax: (syntax,
            head: (verb,
                vform: fin)))
    ===>
    cat> (word,One,
            comps: [(noun,
                case: acc)],
            syntax: (syntax,
                head: (verb,
                    vform: fin))),
    cat> (word,Two,
            comps: [],
            syntax: (syntax,
                head: (noun,
                    case: acc))).

noun_verbphrase_rule rule 
    (phrase,
        comps: [],
        dtrs: [One, Two],
        syntax: (syntax,
            head: s))
    ===>
    cat> (word,One,
            comps: [],
            syntax: (syntax,
                head: (noun,
                    case: nom))),
    cat> (phrase,Two,
            comps: [],
            syntax: (syntax,
                head: (verb,
                    vform: fin))).

