From: Vijay Khemka <vijaykhemka@fb.com>
Date: Wed, 6 Nov 2019 06:57:42 +0000
Subject: [PATCH] drivers: ipmi: Support for both IPMB Req and Resp
In-Reply-To: <20191106005332.GA2754@minyard.net>
References: <20191105194732.1521963-1-vijaykhemka@fb.com>
 <20191106005332.GA2754@minyard.net>
Message-ID: <63FB7A84-EF61-45CA-9CA7-9564F28B5D42@fb.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



?On 11/5/19, 4:54 PM, "Corey Minyard" <tcminyard at gmail.com on behalf of minyard@acm.org> wrote:

    On Tue, Nov 05, 2019 at 11:47:31AM -0800, Vijay Khemka wrote:
    > Removed check for request or response in IPMB packets coming from
    > device as well as from host. Now it supports both way communication
    > to device via IPMB. Both request and response will be passed to
    > application.
    > 
    > Signed-off-by: Vijay Khemka <vijaykhemka@fb.com>
    > ---
    >  drivers/char/ipmi/ipmb_dev_int.c | 29 +----------------------------
    >  1 file changed, 1 insertion(+), 28 deletions(-)
    > 
    > diff --git a/drivers/char/ipmi/ipmb_dev_int.c b/drivers/char/ipmi/ipmb_dev_int.c
    > index 285e0b8f9a97..7201fdb533d8 100644
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
    > @@ -203,28 +200,6 @@ static u8 ipmb_verify_checksum1(struct ipmb_dev *ipmb_dev, u8 rs_sa)
    >  		ipmb_dev->request.checksum1);
    >  }
    >  
    > -static bool is_ipmb_request(struct ipmb_dev *ipmb_dev, u8 rs_sa)
    > -{
    > -	if (ipmb_dev->msg_idx >= IPMB_REQUEST_LEN_MIN) {
    > -		if (ipmb_verify_checksum1(ipmb_dev, rs_sa))
    > -			return false;
    
    You still need to check the message length and checksum, you just need
    to ignore the req/resp bit.
Yes you are right, I was looking for checksum code after removing it __. I will modify it.
    
    -corey
    
    > -
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
    > -	return false;
    > -}
    > -
    >  /*
    >   * The IPMB protocol only supports I2C Writes so there is no need
    >   * to support I2C_SLAVE_READ* events.
    > @@ -273,9 +248,7 @@ static int ipmb_slave_cb(struct i2c_client *client,
    >  
    >  	case I2C_SLAVE_STOP:
    >  		ipmb_dev->request.len = ipmb_dev->msg_idx;
    > -
    > -		if (is_ipmb_request(ipmb_dev, GET_8BIT_ADDR(client->addr)))
    > -			ipmb_handle_request(ipmb_dev);
    > +		ipmb_handle_request(ipmb_dev);
    >  		break;
    >  
    >  	default:
    > -- 
    > 2.17.1
    > 
    

