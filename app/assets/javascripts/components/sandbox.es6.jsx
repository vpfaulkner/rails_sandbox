class Sandbox extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      name: 'User',
      namespace: 'Admin',
      crud: ['create', 'read', 'update', 'delete'],
      attributes: { name: 'string', email: 'string' },
      singular: false
    };
    this.handleNewInput = this.handleNewInput.bind(this);
  }

  handleNewInput(name, namespace, crud, attributes, singular) {
    this.setState({
      name: name,
      namespace: namespace,
      crud: crud,
      attributes: attributes,
      singular: singular,
    });
  }

  render() {
    return (
      <div className="ui stackable grid">
        <div className="header-container row">
          <PageHeader/>
        </div>
        <div className="row">
          <ResourceForm
            onNewInput={this.handleNewInput}
            name={this.state.name}
            namespace={this.state.namespace}
            crud={this.state.crud}
            attributes={this.state.attributes}
            singular={this.state.singular}
          />
        </div>
        <div className="row">
          <CodeSnippets
            name={this.state.name}
            namespace={this.state.namespace}
            crud={this.state.crud}
            attributes={this.state.attributes}
            singular={this.state.singular}
          />
        </div>
      </div>
    );
  }
};
