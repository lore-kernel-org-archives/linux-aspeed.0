From: Vijay Khemka <vijaykhemka@fb.com>
Date: Thu, 14 Nov 2019 18:05:34 +0000
Subject: [PATCH v4] drivers: ipmi: Support raw i2c packet in IPMB
In-Reply-To: <20191114141037.GP2882@minyard.net>
References: <20191113234133.3790374-1-vijaykhemka@fb.com>
 <20191114141037.GP2882@minyard.net>
Message-ID: <41C671FB-20B4-40F5-94AB-1E750FD91B90@fb.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



?On 11/14/19, 6:11 AM, "Corey Minyard" <tcminyard at gmail.com on behalf of minyard@acm.org> wrote:

    On Wed, Nov 13, 2019 at 03:41:33PM -0800, Vijay Khemka wrote:
    > Many IPMB devices doesn't support smbus protocol and current driver
    > support only smbus devices. Added support for raw i2c packets.
    > 
    > User can define i2c-protocol in device tree to use i2c raw transfer.
    > 
    > Signed-off-by: Vijay Khemka <vijaykhemka@fb.com>
    
    With Aasma's response, I am ok with this.
    
    One thing, though.  This is the slave device on the I2C, not the master
    device that has the issue, right?  So it's at least theoretically
    possible to have one SMBus and one I2C IPMB device on the same master,
    right?
    
    For normal I2C, devices are in the device tree and get added to the
    kernel device handling.  It looks like that is not being done in your
    case.  But really, the "right" way to do this is to have the IPMB slaves
    added as Linux devices and address them that way.  I'm not sure this
    will ever be a real issue, but if it is, there will be some work to do
    to fix it.

I will be happy to address this in follow up patch and need some more info.
    
    -corey
    
    > ---
    >  drivers/char/ipmi/ipmb_dev_int.c | 32 ++++++++++++++++++++++++++++++++
    >  1 file changed, 32 insertions(+)
    > 
    > diff --git a/drivers/char/ipmi/ipmb_dev_int.c b/drivers/char/ipmi/ipmb_dev_int.c
    > index ae3bfba27526..10904bec1de0 100644
    > --- a/drivers/char/ipmi/ipmb_dev_int.c
    > +++ b/drivers/char/ipmi/ipmb_dev_int.c
    > @@ -63,6 +63,7 @@ struct ipmb_dev {
    >  	spinlock_t lock;
    >  	wait_queue_head_t wait_queue;
    >  	struct mutex file_mutex;
    > +	bool is_i2c_protocol;
    >  };
    >  
    >  static inline struct ipmb_dev *to_ipmb_dev(struct file *file)
    > @@ -112,6 +113,25 @@ static ssize_t ipmb_read(struct file *file, char __user *buf, size_t count,
    >  	return ret < 0 ? ret : count;
    >  }
    >  
    > +static int ipmb_i2c_write(struct i2c_client *client, u8 *msg)
    > +{
    > +	struct i2c_msg i2c_msg;
    > +
    > +	/*
    > +	 * subtract 1 byte (rq_sa) from the length of the msg passed to
    > +	 * raw i2c_transfer
    > +	 */
    > +	i2c_msg.len = msg[IPMB_MSG_LEN_IDX] - 1;
    > +
    > +	/* Assign message to buffer except first 2 bytes (length and address) */
    > +	i2c_msg.buf = msg + 2;
    > +
    > +	i2c_msg.addr = GET_7BIT_ADDR(msg[RQ_SA_8BIT_IDX]);
    > +	i2c_msg.flags = client->flags & I2C_CLIENT_PEC;
    > +
    > +	return i2c_transfer(client->adapter, &i2c_msg, 1);
    > +}
    > +
    >  static ssize_t ipmb_write(struct file *file, const char __user *buf,
    >  			size_t count, loff_t *ppos)
    >  {
    > @@ -133,6 +153,12 @@ static ssize_t ipmb_write(struct file *file, const char __user *buf,
    >  	rq_sa = GET_7BIT_ADDR(msg[RQ_SA_8BIT_IDX]);
    >  	netf_rq_lun = msg[NETFN_LUN_IDX];
    >  
    > +	/* Check i2c block transfer vs smbus */
    > +	if (ipmb_dev->is_i2c_protocol) {
    > +		ret = ipmb_i2c_write(ipmb_dev->client, msg);
    > +		return (ret == 1) ? count : ret;
    > +	}
    > +
    >  	/*
    >  	 * subtract rq_sa and netf_rq_lun from the length of the msg passed to
    >  	 * i2c_smbus_xfer
    > @@ -277,6 +303,7 @@ static int ipmb_probe(struct i2c_client *client,
    >  			const struct i2c_device_id *id)
    >  {
    >  	struct ipmb_dev *ipmb_dev;
    > +	struct device_node *np;
    >  	int ret;
    >  
    >  	ipmb_dev = devm_kzalloc(&client->dev, sizeof(*ipmb_dev),
    > @@ -302,6 +329,11 @@ static int ipmb_probe(struct i2c_client *client,
    >  	if (ret)
    >  		return ret;
    >  
    > +	/* Check if i2c block xmit needs to use instead of smbus */
    > +	np = client->dev.of_node;
    > +	if (np && of_get_property(np, "i2c-protocol", NULL))
    > +		ipmb_dev->is_i2c_protocol = true;
    > +
    >  	ipmb_dev->client = client;
    >  	i2c_set_clientdata(client, ipmb_dev);
    >  	ret = i2c_slave_register(client, ipmb_slave_cb);
    > -- 
    > 2.17.1
    > 
    

