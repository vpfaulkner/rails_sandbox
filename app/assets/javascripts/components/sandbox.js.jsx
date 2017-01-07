var Sandbox = React.createClass({
  render() {
    return (
      <div className="ui stackable grid">
        <div className="header-container row">
          <PageHeader/>
        </div>
        <div className="row">
          <ResourceForm/>
        </div>
        <div className="row">
          <CodeSnippets/>
        </div>
      </div>
    );
  },
});
