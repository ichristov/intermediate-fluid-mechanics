<!--
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Credit: Initial version written by [Ivan C. Christov](http://christov.tmnt-lab.org),    %%
%% Purdue University.                                                                      %%
%% License: GPLv3 (see https://www.gnu.org/licenses/gpl-3.0.en.html)                       %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
-->

# Writing Tips and Best Practices for Assignments

Prof. Ivan C. Christov, Purdue University, ME 50900

## Introduction

In science and engineering, writing is a primary means of communicating
ideas. Whether it's project reports, journal articles, proposals,
manuals, or even emails and memos, clear writing helps others understand
your work. As a graduate student, you'll likely find that more people
read your writing than hear you present. That means even the most
innovative ideas can be overlooked if they aren't explained clearly and
professionally. Strong technical writing skills are essential for
effectively sharing your research, making a positive impression, and
advancing in both academia and industry.

In this course, you'll be communicating your knowledge of the material
in written form via written assignments, such as problem sets. These
assignments present you with an ideal opportunity to practice your
technical communication skills.

I encourage you to emulate the format used in the solutions to the
problem sets that I will provide. These solutions have been carefully
prepared, including typesetting the equations and providing graphical
illustrations and references where needed to make them thorough and easy
to follow. Thus, I hope they stand as good examples of high-quality
technical writing.

## Some tips and best practices

1.  Show your work, write neatly, and explain logically. Although **it
    is not required for this class**, it is recommended. However,
    typesetting reports is expected in professional practice. Try using
    [Overleaf](https://www.overleaf.com/edu/purdue) (based on the
    powerful gold-standard LaTeX typesetting language, which you can
    learn to use in [30
    minutes](https://www.overleaf.com/learn/latex/Learn_LaTeX_in_30_minutes)).
    It would be beneficial for you to learn how to use such software
    effectively.

2.  Explain your solution process. Don't just list many equations on the page,
    and sprint towards a potential answer. Instead, [explain what the
    equations mean in words](https://pubs.aip.org/asa/poma/article/54/1/025002/3352466/Helping-students-learn-to-read-mathematical),
    then guide the reader (grader) through how you're manipulating the
    equations to arrive at the solution (often a symbolic expression in
    this course).

3.  Don't skip too many steps. You're more likely to make mistakes that
    way, making it harder for the reader (grader) to follow. Err on the
    side of more detail.

4.  Always start from the basic equations and simplify from there using
    assumptions and givens.

5.  Clearly identify significant assumptions you've made, and when and
    where you've used these assumptions (or givens) to make a
    simplification. Going back to item 2, the idea is to logically
    and unambiguously explain how you arrived at the answer.

6.  Consider using figures, diagrams, or schematics in your solution.
    Most of us absorb information more effectively through visual means.
    As needed, sketch the problem setup. Use high-quality plots to
    support your conclusions. Although it is helpful to have figures
    close to the text/results they are contributing, don't stress over
    precise location, especially if using LaTeX, which has its own
    sophisticated rules about what placement "looks best."

7.  Define your variables. Be consistent in their use. Ideally, don't
    stray too far from the notation used in class or on the assignment.

8.  Include units with your numerical values. Verify that your unit
    conversions are correct.

9.  Clearly identify when a variable is a scalar (such as $f(x)$, $5$,
    or $b$), vector (such as $\underline{v}$, $\vec{v}$, or <b>$\boldsymbol{v}$</b>),
    or a tensor (such as $\underline{\underline{T}}$, $\vec{\vec{T}}$,
    or <b>$\boldsymbol{T}$</b>). Just like with units, your use of scalars,
    vectors, and tensors in algebraic equations should be consistent.

10. If typing your assignment:

    *   Input mathematical symbols and expressions in "math mode" to
        ensure they are typeset correctly (usually that means in
        *italics*). If using Word, use "insert equation." If using
        LaTeX, use dollar signs `$...$` or `\begin{ } ... \end{ }`
        environments to enclose the math expression. For example, ensure
        your output is "The shear rate $\dot{\gamma}$ increases as \..."
        instead of "The shear rate y increases as \..." In this example,
        I'm also illustrating the proper use of
        [Greek letters](https://www.overleaf.com/learn/latex/List_of_Greek_letters_and_math_symbols); avoid
        using a "close enough" Latin letter. 🙂

    *   If you want to learn about advanced equation typesetting, I
        recommend the [Short Math Guide for
        LaTeX](https://ctan.org/pkg/short-math-guide).

    *   Don't italicize units. Units are "text," they are not "math."
        That is, write "$101.3~\text{kPa}$" instead of
        "$101.3~kPa$." Furthermore, ensure there is a space between
        numbers and units, that is, write "$101.3~\text{kPa}$"
        instead of "$101.3\text{kPa}$."

        -   Consider using the LaTeX package
            [`siunitx`](https://ctan.org/pkg/siunitx), which allows you
            to typeset units as `\si{\name}`. That is, write
            "`$101.3~\si{\kilo\pascal}$`" instead of "`$101.3~kPa$`" or
            "`$101.3$ kPa`".

        -   In LaTeX math mode, spaces don't matter. If you want to
            ensure two symbols are separated appropriately, use a tilde
            (`~`) to connect them, that is, write
            "`$101.3~\si{\kilo\pascal}$`" instead of
            "`$101.3 \si{\kilo\pascal}$`".\
            Furthermore, in LaTeX, `~` signifies and *nonbreaking*
            space. You don't want your units to end up on the next line
            after the value. In Word, a nonbreaking space is inserted
            via the key combination CTRL+SHIFT+SPACE.

        -   Note that in LaTeX left quotes are `` ` `` (or coded as
            `\lq`), which is a different key than `'`. To get double
            quotation marks, press `` ` `` twice, ``` `` ```. To close
            the quote, press `'` twice, `''`.

        -   Also note that LaTeX assumes periods denote the end of a
            sentence, which requires extra space after the period.
            However, we often use periods in the middle of a sentence,
            in constructions such as "Eq." or "et al." To ensure proper
            spacing, code these expressions as "`Eq.\ (1)`" or
            "`Smith et al.\ claim`" the backslash after the period tells
            LaTeX that this period is not the end of a sentence. \
            (Or, you can use a nonbreaking space: "`Eq.~(1)`".)

11. Use equation numbers if you want to refer back to them later in your
    solution. For example, "Substituting $x=3$ in Eq. (5), we arrive at
    \..." If using LaTeX, give your equations labels using
    `\label{name}` and reference them using `\eqref{name}` (available
    from the [`amsmath`](https://ctan.org/pkg/amsmath) package) for
    automatic numbering. If you are using Word, you're on your
    own\...good luck. 🙂

12. Number pages in your document.

13. As Dr. Nicole Sharp points out in her article "[Adopting a
    communication lifestyle](https://dx.doi.org/10.1103/PhysRevFluids.5.110515)"
    ([access via Purdue libraries](https://journals-aps-org.ezproxy.lib.purdue.edu/prfluids/abstract/10.1103/PhysRevFluids.5.110515); login required),
    craft your submission by

    *   identifying big-picture issues around goals, audience, and
        message;

    *   constructing a first version of the product;

    *   evaluating and refining the product based on the bigger picture
        and outside feedback; and

    *   reflecting on the lessons learned during the project.

    In other words, review your final written solution, think about how
    it might look from the reader's (grader's) perspective, and revise
    as needed.

14. Consider doing a basic grammar check of your writing using a tool
    such as LanguageTool, Writefull, or Grammarly, all of which have a
    *free* version and integrate with Overleaf and/or via browser
    extensions. There's generally no need for over-the-top
    [purple prose](https://en.wikipedia.org/wiki/Purple_prose)
    in scientific writing (such as that produced by large-language models,
    say ChatGPT), but fixing basic grammar helps readability.

15. When preparing plots:

    *   Make sure the size of axes, labels, legends, etc. is easy to
        read. Don't use bold fonts unless you're specifically denoting
        vectors or tensors.

    *   Make sure your plot symbols are clear and discernible. Don't
        reuse plot symbols for multiple datasets.

    *   Don't put a title on the plot itself; any discussion of the plot
        (or what it represents) should be placed below it as a figure
        caption.

    *   Do not take screenshots, as they can be of low quality and
        [pixelated](https://upload.wikimedia.org/wikipedia/commons/3/3e/Applepix.png).
        Use the plotting software's built-in function (or button) to
        save a plot in a high-quality vector format, such as PDF.

    *   Label your axes, plot symbols, and plot curves.

    *   Make sure the legend doesn't cover the plot.

    *   Use scientific notation instead of coding notation. For example,
        write "$F=1.6\times10^{7}~\mathrm{N}$" instead of
        "$F = 1.6e7~\mathrm{N}$." Note that $\times$ (coded `$\times$`) is a
        [special symbol](https://en.wikipedia.org/wiki/Multiplication_sign);
        it is *not* the math variable $x$ (coded `$x$`) in a different font.

    *   Generally, use solid lines (or curves) for theory/predicted
        values and symbols for discrete data obtained from
        experiments/simulations. To avoid confusion, don't connect data
        points from experiments/simulations with line segments.

    *   If your figure contains multiple subplots, say (a), (b), (c),
        etc., and make sure that the axis ranges are the same across
        subplots if you are comparing the same quantity across them.

16. Tables should be reserved for cataloging many sets of values
    relevant to the problem, such as the thermophysical properties of
    the fluid, or the dimensions of the flow geometry. Generally, we
    will not need to do that in this course. Tables should be used
    sparingly. Output data and results are more effectively displayed as
    figures rather than tables.

17. Never use Excel charts (especially the 3D ones and related
    atrocities) to convey quantitative scientific data.

18. Further reading:

    *   "[A Guide to Writing
        Mathematics](http://www.cs.ucdavis.edu/~amenta/w10/writingman.pdf)"
        by Dr. Kevin P. Lee.

    *   [*Handbook of Writing for the Mathematical
        Sciences*](https://nhigham.com/handbook-of-writing-for-the-mathematical-sciences/)
        by Prof. Nicholas J. Higham ([access via Purdue Libraries](https://purdue.primo.exlibrisgroup.com/permalink/01PURDUE_PUWL/ufs51j/alma99169877700501081);
        login required).

    *   The [Purdue Online Writing Laboratory](https://owl.purdue.edu/).

---

Prof. Ivan C. Christov, Purdue University, ME 50900
