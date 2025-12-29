# QWEN.md - reblocks-ui2 Project

## Project Overview

reblocks-ui2 is a comprehensive UI component library for the Reblocks web framework written in Common Lisp. It provides a rich set of reusable UI components for building modern web applications. The library includes components such as buttons, cards, forms, tables, input fields, containers, and more, all designed to work within the Reblocks framework.

### Key Features

- **Component-based Architecture**: The library provides a wide range of UI components including buttons, cards, forms, tables, input fields, and various containers.
- **Theming Support**: Includes a theming system with Tailwind CSS support, allowing for consistent styling across components.
- **Widget System**: Built on top of Reblocks' widget system with enhanced capabilities for state management and rendering.
- **CSS-in-JS**: Features an `html` macro that allows defining HTML, CSS, and event handlers in a single form with state management.
- **Responsive Design**: Components support various sizes and responsive layouts.

### Main Components

The library includes:

- Buttons with various styles (normal, outlined, raised, with different colors)
- Card components for grouping content
- Form components with validation support
- Table components with editable functionality
- Input components (text input, etc.) with validation
- Container components (row, column, stack, tabs)
- Icon support
- Theming system with Tailwind integration
- Utilities for alignment, margin, padding, and sizing

## Building and Running

### Prerequisites

- Roswell (for using `ros run` command)
- Common Lisp implementation (e.g., SBCL, CCL) 
- Quicklisp for dependency management
- ASDF 3.1 or later

### Installation

The library can be installed through Quicklisp:

```lisp
(ql:quickload :reblocks-ui2)
```

For the latest development version, the project recommends installing from Ultralisp:

```lisp
(ql-dist:install-dist "http://dist.ultralisp.org/"
                      :prompt nil)
(ql:quickload :reblocks-ui2)
```

### Running the Demo

To run the demo application:

```lisp
(ql:quickload :reblocks-ui2-demo)
```

The demo system is defined in `reblocks-ui2-demo.asd` and includes a sample application showcasing the various UI components.

### Testing

To run the tests:

```lisp
(asdf:test-system :reblocks-ui2-tests)
```

When running Lisp code, use:

```bash
qlot exec ros run --eval '(some code)'
```

Instead of plain SBCL or ros run.

## Development Conventions

### Code Structure

The codebase follows Common Lisp conventions with a focus on:

- Package-inferred systems for better modularity
- Clear separation of concerns between UI components, themes, and utilities
- Consistent naming conventions following Common Lisp standards

### Architecture

The library is structured around:

- **Widget System**: The core `ui-widget` class extends Reblocks' widget functionality with theming support
- **Theming**: A flexible theming system with Tailwind integration
- **HTML Rendering**: The `html` macro provides a unified approach to define UI, CSS, and state in one place
- **Component Hierarchy**: Clear inheritance hierarchy for different types of UI components

### Component Development

When developing new components:

1. Components should inherit from `ui-widget` or appropriate base classes
2. Implement the `reblocks-ui2/widget:render` method for theme-specific rendering
3. Use the `html` macro for defining component structure and behavior
4. Follow the theming API to ensure compatibility with different themes

## Dependencies

The project depends on several key libraries:

- `reblocks`: The web framework that reblocks-ui2 extends
- `reblocks-lass`: For CSS generation
- `alexandria`: Common Lisp utilities
- `anaphora`: Anaphoric macros
- `closer-mop`: Meta-object protocol utilities
- `parenscript`: For client-side JavaScript generation
- `serapeum`: Additional Common Lisp utilities
- `named-readtables`: For syntax extensions
- `pythonic-string-reader`: For Python-style string syntax

The library uses the 40ANTS documentation and ASDF system for packaging and documentation generation.
