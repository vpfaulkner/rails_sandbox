var ResourceForm = React.createClass({
  render() {
    return (
      <div className="sixteen wide column">
        <h3 className="ui header">Resource</h3>
        <form className="ui form">
          <div className="fields">
            <div className="two wide field name">
              <label>Name</label>
              <input className="form-field" type="text" name="name" value="User" placeholder="User"/>
            </div>
            <div className="two wide field namespace">
              <label>Namespace</label>
              <input className="form-field" type="text" name="namespace" value="Admin"/>
            </div>
            <div className="six wide field crud">
              <label>CRUD</label>
              <select multiple="" className="ui fluid dropdown form-field" id="crud">
                <option selected className="crud" value="create">Create</option>
                <option selected className="crud" value="read">Read</option>
                <option selected className="crud" value="update">Update</option>
                <option selected className="crud" value="delete">Delete</option>
              </select>
            </div>
            <div className="two wide field attributes">
              <label>Attributes</label>
              <div className="ui fluid bottom aligned attribute-button button">
                Select <i className="dropdown icon"></i>
              </div>
              <div id="attributes-popup" className="ui fluid popup top left transition hidden">
                <div className="ui middle aligned grid attribute-grid">
                  <div className="row attribute-row">
                    <div className="two wide column">
                      <i className="attribute-icon delete icon"></i>
                    </div>
                    <div className="seven wide column field">
                      <input className="form-field attribute" type="text" name="attribute-name" placeholder="Attribute" value="Name"/>
                    </div>
                    <div className="six wide column field">
                      <div className="ui fluid dropdown form-field disabled-attribute selection disabled" tabindex="0">
                        <select name="type" id="type" disabled="disabled">
                          <option value="">Select type</option><option value="string">string</option>
                          <option value="text">text</option>
                          <option value="binary">binary</option>
                          <option value="integer">integer</option>
                          <option value="date">date</option>
                          <option value="datetime">datetime</option>
                          <option value="boolean">boolean</option>
                          <option value="decimal">decimal</option>
                          <option value="float">float</option>
                          <option value="time">time</option>
                          <option value="primary_key">primary_key</option>
                          <option value="references">references</option>
                          <option value="timestamp">timestamp</option>
                        </select>
                      </div>
                    </div>
                  </div>
                  <div className="row attribute-row">
                    <div className="two wide column">
                      <i className="attribute-icon delete icon"></i>
                    </div>
                    <div className="seven wide column field">
                      <input className="form-field attribute" name="attribute-name" type="text" placeholder="Attribute" value="Email"/>
                    </div>
                    <div className="six wide column field">
                      <div className="ui fluid dropdown form-field disabled-attribute selection disabled" tabindex="0">
                        <select name="type" id="type" disabled="disabled">
                          <option value="">Select type</option><option value="string">string</option>
                          <option value="text">text</option>
                          <option value="binary">binary</option>
                          <option value="integer">integer</option>
                          <option value="date">date</option>
                          <option value="datetime">datetime</option>
                          <option value="boolean">boolean</option>
                          <option value="decimal">decimal</option>
                          <option value="float">float</option>
                          <option value="time">time</option>
                          <option value="primary_key">primary_key</option>
                          <option value="references">references</option>
                          <option value="timestamp">timestamp</option>
                        </select>
                      </div>
                    </div>
                  </div>
                  <div className="row">
                    <div className="two wide column">
                    </div>
                    <div className="seven wide column field disabled-attribute">
                      <input type="text" placeholder="Add Attribute" disabled="" className="disabled-attribute"/>
                    </div>
                    <div className="six wide column field">
                      <div className="ui fluid dropdown form-field disabled-attribute selection disabled" tabindex="0">
                        <select name="type" id="type" disabled="disabled">
                          <option value="">Select type</option><option value="string">string</option>
                          <option value="text">text</option>
                          <option value="binary">binary</option>
                          <option value="integer">integer</option>
                          <option value="date">date</option>
                          <option value="datetime">datetime</option>
                          <option value="boolean">boolean</option>
                          <option value="decimal">decimal</option>
                          <option value="float">float</option>
                          <option value="time">time</option>
                          <option value="primary_key">primary_key</option>
                          <option value="references">references</option>
                          <option value="timestamp">timestamp</option>
                        </select>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
            <div className="one wide field singular">
              <label>Singular?</label>
              <div className="ui toggle checkbox checkbox-container">
                <input className="singular-checkbox form-field" type="checkbox" name="singular"/>
                <label></label>
              </div>
            </div>
          </div>
        </form>
      </div>
    );
  },
});
