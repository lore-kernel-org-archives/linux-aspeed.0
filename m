From: Vijay Khemka <vijaykhemka@fb.com>
Date: Fri, 3 May 2019 17:55:08 +0000
Subject: [PATCH] misc: aspeed-lpc-ctrl: Correct return values
In-Reply-To: <6defa7bc-ec29-4418-b05c-fb96c03621f6@www.fastmail.com>
References: <20190501223836.1670096-1-vijaykhemka@fb.com>
 <20190502064021.GA14911@kroah.com>
 <6defa7bc-ec29-4418-b05c-fb96c03621f6@www.fastmail.com>
Message-ID: <84663B1E-0FD1-4B71-A49C-AB70110CB8A0@fb.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



?On 5/1/19, 11:49 PM, "Andrew Jeffery" <andrew@aj.id.au> wrote:

    
    
    On Thu, 2 May 2019, at 16:10, Greg Kroah-Hartman wrote:
    > On Wed, May 01, 2019 at 03:38:36PM -0700, Vijay Khemka wrote:
    > > Corrected some of return values with appropriate meanings.
    > > 
    > > Signed-off-by: Vijay Khemka <vijaykhemka@fb.com>
    > > ---
    > >  drivers/misc/aspeed-lpc-ctrl.c | 15 +++++++--------
    > >  1 file changed, 7 insertions(+), 8 deletions(-)
    > > 
    > > diff --git a/drivers/misc/aspeed-lpc-ctrl.c b/drivers/misc/aspeed-lpc-ctrl.c
    > > index 332210e06e98..97ae341109d5 100644
    > > --- a/drivers/misc/aspeed-lpc-ctrl.c
    > > +++ b/drivers/misc/aspeed-lpc-ctrl.c
    > > @@ -68,7 +68,6 @@ static long aspeed_lpc_ctrl_ioctl(struct file *file, unsigned int cmd,
    > >  		unsigned long param)
    > >  {
    > >  	struct aspeed_lpc_ctrl *lpc_ctrl = file_aspeed_lpc_ctrl(file);
    > > -	struct device *dev = file->private_data;
    > >  	void __user *p = (void __user *)param;
    > >  	struct aspeed_lpc_ctrl_mapping map;
    > >  	u32 addr;
    > 
    > This change is not reflected in your changelog text :(
    > 
    > Please fix up, or break this up into multiple patches.
    
    The return value fixes should also be squashed into the patch that introduced those lines
    given it hasn't yet been applied.
    
    Further, IIRC I previously suggested removing the dev_err()s entirely, not just switching
    them to pr_err(). Returning an error code is enough IMO, there's no need to pollute the
    kernel logs with application-level errors. Or make them dev_dbg().

Alright, I will replace with dev_dbg(), information can still be extracted by user with debug.
    
    Andrew
    
    > 
    > greg k-h
    >
    

