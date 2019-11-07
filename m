From: Vijay Khemka <vijaykhemka@fb.com>
Date: Thu, 7 Nov 2019 21:21:24 +0000
Subject: [PATCH v2] drivers: ipmi: Support for both IPMB Req and Resp
In-Reply-To: <20191107133425.GA10276@minyard.net>
References: <20191106182921.1086795-1-vijaykhemka@fb.com>
 <20191107133425.GA10276@minyard.net>
Message-ID: <0D4A68FC-E829-4890-B720-F9A6110A5038@fb.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



?On 11/7/19, 5:35 AM, "Corey Minyard" <tcminyard at gmail.com on behalf of minyard@acm.org> wrote:

    On Wed, Nov 06, 2019 at 10:29:21AM -0800, Vijay Khemka wrote:
    > Removed check for request or response in IPMB packets coming from
    > device as well as from host. Now it supports both way communication
    > to device via IPMB. Both request and response will be passed to
    > application.
    > 
    > Signed-off-by: Vijay Khemka <vijaykhemka@fb.com>
    
    Thanks, this is in my for-next tree now.  Asnaam, I took your previous
    comments as a "Reviewed-by", if that is ok.

Thanks Corey
    
    -corey
    
    > ---
    >  drivers/char/ipmi/ipmb_dev_int.c | 31 +++++++++----------------------
    >  1 file changed, 9 insertions(+), 22 deletions(-)
    > 
    > diff --git a/drivers/char/ipmi/ipmb_dev_int.c b/drivers/char/ipmi/ipmb_dev_int.c
    > index 285e0b8f9a97..ae3bfba27526 100644
    > --- a/drivers/char/ipmi/ipmb_dev_int.c
    > +++ b/drivers/char/ipmi/ipmb_dev_int.c
    > @@ -133,9 +133,6 @@ static ssize_t ipmb_write(struct file *file, const char __user *buf,
    >  	rq_sa = GET_7BIT_ADDR(msg[RQ_SA_8BIT_IDX]);
    >  	netf_rq_lun = msg[NETFN_LUN_IDX];
    >  
    > -	if (!(netf_rq_lun & NETFN_RSP_BIT_MASK))
    > -		return -EINVAL;
    > -
    >  	/*
    >  	 * subtract rq_sa and netf_rq_lun from the length of the msg passed to
    >  	 * i2c_smbus_xfer
    > @@ -203,25 +200,16 @@ static u8 ipmb_verify_checksum1(struct ipmb_dev *ipmb_dev, u8 rs_sa)
    >  		ipmb_dev->request.checksum1);
    >  }
    >  
    > -static bool is_ipmb_request(struct ipmb_dev *ipmb_dev, u8 rs_sa)
    > +/*
    > + * Verify if message has proper ipmb header with minimum length
    > + * and correct checksum byte.
    > + */
    > +static bool is_ipmb_msg(struct ipmb_dev *ipmb_dev, u8 rs_sa)
    >  {
    > -	if (ipmb_dev->msg_idx >= IPMB_REQUEST_LEN_MIN) {
    > -		if (ipmb_verify_checksum1(ipmb_dev, rs_sa))
    > -			return false;
    > +	if ((ipmb_dev->msg_idx >= IPMB_REQUEST_LEN_MIN) &&
    > +	   (!ipmb_verify_checksum1(ipmb_dev, rs_sa)))
    > +		return true;
    >  
    > -		/*
    > -		 * Check whether this is an IPMB request or
    > -		 * response.
    > -		 * The 6 MSB of netfn_rs_lun are dedicated to the netfn
    > -		 * while the remaining bits are dedicated to the lun.
    > -		 * If the LSB of the netfn is cleared, it is associated
    > -		 * with an IPMB request.
    > -		 * If the LSB of the netfn is set, it is associated with
    > -		 * an IPMB response.
    > -		 */
    > -		if (!(ipmb_dev->request.netfn_rs_lun & NETFN_RSP_BIT_MASK))
    > -			return true;
    > -	}
    >  	return false;
    >  }
    >  
    > @@ -273,8 +261,7 @@ static int ipmb_slave_cb(struct i2c_client *client,
    >  
    >  	case I2C_SLAVE_STOP:
    >  		ipmb_dev->request.len = ipmb_dev->msg_idx;
    > -
    > -		if (is_ipmb_request(ipmb_dev, GET_8BIT_ADDR(client->addr)))
    > +		if (is_ipmb_msg(ipmb_dev, GET_8BIT_ADDR(client->addr)))
    >  			ipmb_handle_request(ipmb_dev);
    >  		break;
    >  
    > -- 
    > 2.17.1
    > 
    

