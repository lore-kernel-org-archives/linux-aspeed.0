From: Vijay Khemka <vijaykhemka@fb.com>
Date: Thu, 14 Nov 2019 22:16:20 +0000
Subject: [PATCH v5] drivers: ipmi: Support raw i2c packet in IPMB
In-Reply-To: <DB6PR0501MB2712B06FB162520F90EF1F4DDA710@DB6PR0501MB2712.eurprd05.prod.outlook.com>
References: <20191114185359.2832107-1-vijaykhemka@fb.com>
 <DB6PR0501MB2712B06FB162520F90EF1F4DDA710@DB6PR0501MB2712.eurprd05.prod.outlook.com>
Message-ID: <10DAB69C-D4F3-4472-935E-07FAD90B8EF6@fb.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Sure I will update commit message

?On 11/14/19, 1:41 PM, "Asmaa Mnebhi" <Asmaa@mellanox.com> wrote:

    
    -----Original Message-----
    From: Vijay Khemka <vijaykhemka@fb.com> 
    Sent: Thursday, November 14, 2019 1:54 PM
    To: Jonathan Corbet <corbet@lwn.net>; Corey Minyard <minyard@acm.org>; Arnd Bergmann <arnd@arndb.de>; Greg Kroah-Hartman <gregkh@linuxfoundation.org>; linux-doc at vger.kernel.org; linux-kernel at vger.kernel.org; openipmi-developer at lists.sourceforge.net
    Cc: vijaykhemka at fb.com; cminyard at mvista.com; Asmaa Mnebhi <Asmaa@mellanox.com>; joel at jms.id.au; linux-aspeed at lists.ozlabs.org; sdasari at fb.com
    Subject: [PATCH v5] drivers: ipmi: Support raw i2c packet in IPMB
    
    Many IPMB devices doesn't support smbus protocol and current driver support only smbus devices. Added support for raw i2c packets.
    
    User can define i2c-protocol in device tree to use i2c raw transfer.
    
    Asmaa >> It would be good if you can rephrase the above description as follows:
    "The ipmb_dev_int driver only supports the smbus protocol at the moment. Add support for the i2c protocol as well. There will be a variable passed by the device tree or ACPI table which determines whether the protocol is i2c or smbus."
    
    Or at least fix the following: 
    "Many IPMB devices doesn't" -> "Many IPMB devices don't"
    "current driver support" -> "current driver supports"
    
    Besides my above comment:
    Reviewed-by: Asmaa Mnebhi <asmaa@mellanox.com>
    
    Signed-off-by: Vijay Khemka <vijaykhemka@fb.com>
    ---
     Documentation/IPMB.txt           |  4 ++++
     drivers/char/ipmi/ipmb_dev_int.c | 29 +++++++++++++++++++++++++++++
     2 files changed, 33 insertions(+)
    
    diff --git a/Documentation/IPMB.txt b/Documentation/IPMB.txt index a6ed8b68bd0f..7a023beff976 100644
    --- a/Documentation/IPMB.txt
    +++ b/Documentation/IPMB.txt
    @@ -71,9 +71,13 @@ b) Example for device tree:
              ipmb at 10 {
                      compatible = "ipmb-dev";
                      reg = <0x10>;
    +                 i2c-protocol;
              };
     };
     
    +If xmit of data to be done using raw i2c block vs smbus then 
    +"i2c-protocol" needs to be defined as above.
    +
     2) Manually from Linux:
     modprobe ipmb-dev-int
     
    diff --git a/drivers/char/ipmi/ipmb_dev_int.c b/drivers/char/ipmi/ipmb_dev_int.c
    index ae3bfba27526..68a254c0dd92 100644
    --- a/drivers/char/ipmi/ipmb_dev_int.c
    +++ b/drivers/char/ipmi/ipmb_dev_int.c
    @@ -63,6 +63,7 @@ struct ipmb_dev {
     	spinlock_t lock;
     	wait_queue_head_t wait_queue;
     	struct mutex file_mutex;
    +	bool is_i2c_protocol;
     };
     
     static inline struct ipmb_dev *to_ipmb_dev(struct file *file) @@ -112,6 +113,25 @@ static ssize_t ipmb_read(struct file *file, char __user *buf, size_t count,
     	return ret < 0 ? ret : count;
     }
     
    +static int ipmb_i2c_write(struct i2c_client *client, u8 *msg, u8 addr) 
    +{
    +	struct i2c_msg i2c_msg;
    +
    +	/*
    +	 * subtract 1 byte (rq_sa) from the length of the msg passed to
    +	 * raw i2c_transfer
    +	 */
    +	i2c_msg.len = msg[IPMB_MSG_LEN_IDX] - 1;
    +
    +	/* Assign message to buffer except first 2 bytes (length and address) */
    +	i2c_msg.buf = msg + 2;
    +
    +	i2c_msg.addr = addr;
    +	i2c_msg.flags = client->flags & I2C_CLIENT_PEC;
    +
    +	return i2c_transfer(client->adapter, &i2c_msg, 1); }
    +
     static ssize_t ipmb_write(struct file *file, const char __user *buf,
     			size_t count, loff_t *ppos)
     {
    @@ -133,6 +153,12 @@ static ssize_t ipmb_write(struct file *file, const char __user *buf,
     	rq_sa = GET_7BIT_ADDR(msg[RQ_SA_8BIT_IDX]);
     	netf_rq_lun = msg[NETFN_LUN_IDX];
     
    +	/* Check i2c block transfer vs smbus */
    +	if (ipmb_dev->is_i2c_protocol) {
    +		ret = ipmb_i2c_write(ipmb_dev->client, msg, rq_sa);
    +		return (ret == 1) ? count : ret;
    +	}
    +
     	/*
     	 * subtract rq_sa and netf_rq_lun from the length of the msg passed to
     	 * i2c_smbus_xfer
    @@ -302,6 +328,9 @@ static int ipmb_probe(struct i2c_client *client,
     	if (ret)
     		return ret;
     
    +	ipmb_dev->is_i2c_protocol
    +		= device_property_read_bool(&client->dev, "i2c-protocol");
    +
     	ipmb_dev->client = client;
     	i2c_set_clientdata(client, ipmb_dev);
     	ret = i2c_slave_register(client, ipmb_slave_cb);
    --
    2.17.1
    
    

