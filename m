From: Vijay Khemka <vijaykhemka@fb.com>
Date: Mon, 11 Feb 2019 20:13:15 +0000
Subject: [PATCH] misc: aspeed-lpc-ctrl: Correct return values
In-Reply-To: <1549862567.1175306.1655243744.11AFF30D@webmail.messagingengine.com>
References: <20190123230634.1815021-1-vijaykhemka@fb.com>
 <20190124081544.GA1649@kroah.com>
 <13C13AE8-63A4-4002-9E0D-70276C529448@fb.com>
 <1549862567.1175306.1655243744.11AFF30D@webmail.messagingengine.com>
Message-ID: <F4D4C25B-5E76-4E50-97E7-5A3548BBA1C4@fb.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



?On 2/10/19, 9:22 PM, "Andrew Jeffery" <andrew@aj.id.au> wrote:

    On Fri, 25 Jan 2019, at 05:59, Vijay Khemka wrote:
    > 
    > 
    > On 1/24/19, 12:16 AM, "Greg Kroah-Hartman" <gregkh@linuxfoundation.org> wrote:
    > 
    >     On Wed, Jan 23, 2019 at 03:06:34PM -0800, Vijay Khemka wrote:
    >     > Corrected some of return values with appropriate meanings.
    >     > 
    >     > Signed-off-by: Vijay Khemka <vijaykhemka@fb.com>
    >     > ---
    >     >  drivers/misc/aspeed-lpc-ctrl.c | 15 +++++++--------
    >     >  1 file changed, 7 insertions(+), 8 deletions(-)
    >     > 
    >     > diff --git a/drivers/misc/aspeed-lpc-ctrl.c b/drivers/misc/aspeed-
    > lpc-ctrl.c
    >     > index 332210e06e98..97ae341109d5 100644
    >     > --- a/drivers/misc/aspeed-lpc-ctrl.c
    >     > +++ b/drivers/misc/aspeed-lpc-ctrl.c
    >     > @@ -68,7 +68,6 @@ static long aspeed_lpc_ctrl_ioctl(struct file 
    > *file, unsigned int cmd,
    >     >  		unsigned long param)
    >     >  {
    >     >  	struct aspeed_lpc_ctrl *lpc_ctrl = file_aspeed_lpc_ctrl(file);
    >     > -	struct device *dev = file->private_data;
    >     >  	void __user *p = (void __user *)param;
    >     >  	struct aspeed_lpc_ctrl_mapping map;
    >     >  	u32 addr;
    >     > @@ -93,8 +92,8 @@ static long aspeed_lpc_ctrl_ioctl(struct file 
    > *file, unsigned int cmd,
    >     >  
    >     >  		/* If memory-region is not described in device tree */
    >     >  		if (!lpc_ctrl->mem_size) {
    >     > -			dev_err(dev, "Didn't find reserved memory\n");
    >     > -			return -EINVAL;
    >     > +			pr_err("aspeed_lpc_ctrl: ioctl: Didn't find reserved memory\n");
    >     
    >     Why did you change from dev_err() to pr_err()?  You just lost a lot of
    >     information that the user previously was getting from dev_err() :(
    > 
    > I did this as per review comment from Andrew Jeffery, as we don't want 
    > to put this error for driver. It has to be handled by userspace. But I 
    > am still reporting some error here.
    
    Sorry? What I was trying to suggest was removing the logging altogether and
    just returning the error code. Not simply changing how the logging is done.
No issue, I can remove logging, will just return error code. Will send new patch with update.
    
    Andrew
    

