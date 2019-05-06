From: Vijay Khemka <vijaykhemka@fb.com>
Date: Mon, 6 May 2019 18:04:39 +0000
Subject: [PATCH v2] misc: aspeed-lpc-ctrl: Correct return values
In-Reply-To: <76491a70-01ca-4308-a09e-4f223ac49ebd@www.fastmail.com>
References: <20190503181336.579877-1-vijaykhemka@fb.com>
 <76491a70-01ca-4308-a09e-4f223ac49ebd@www.fastmail.com>
Message-ID: <FEC308F1-3AF0-4C0D-A082-59B4062A2F0F@fb.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



?On 5/5/19, 9:24 PM, "Andrew Jeffery" <andrew@aj.id.au> wrote:

    
    
    On Sat, 4 May 2019, at 03:43, Vijay Khemka wrote:
    > Corrected some of return values with appropriate meanings and reported
    > relevant messages as debug information.
    > 
    > Signed-off-by: Vijay Khemka <vijaykhemka@fb.com>
    
    Thanks for the fixes, this looks okay now. However, was there a reason for
    not squashing change into your previous patch that introduced the issues
    this fixes? That hasn't been applied yet either as far as I'm aware. I'd prefer
    we do that and submit a single, good patch if we can.

First patch has already been applied to LF openbmc kernel and being used by many
people so I wanted to keep this clean.
    
    Andrew
    
    > ---
    >  drivers/misc/aspeed-lpc-ctrl.c | 14 +++++++-------
    >  1 file changed, 7 insertions(+), 7 deletions(-)
    > 
    > diff --git a/drivers/misc/aspeed-lpc-ctrl.c 
    > b/drivers/misc/aspeed-lpc-ctrl.c
    > index 332210e06e98..aca13779764a 100644
    > --- a/drivers/misc/aspeed-lpc-ctrl.c
    > +++ b/drivers/misc/aspeed-lpc-ctrl.c
    > @@ -93,8 +93,8 @@ static long aspeed_lpc_ctrl_ioctl(struct file *file, 
    > unsigned int cmd,
    >  
    >  		/* If memory-region is not described in device tree */
    >  		if (!lpc_ctrl->mem_size) {
    > -			dev_err(dev, "Didn't find reserved memory\n");
    > -			return -EINVAL;
    > +			dev_dbg(dev, "Didn't find reserved memory\n");
    > +			return -ENXIO;
    >  		}
    >  
    >  		map.size = lpc_ctrl->mem_size;
    > @@ -134,16 +134,16 @@ static long aspeed_lpc_ctrl_ioctl(struct file 
    > *file, unsigned int cmd,
    >  
    >  		if (map.window_type == ASPEED_LPC_CTRL_WINDOW_FLASH) {
    >  			if (!lpc_ctrl->pnor_size) {
    > -				dev_err(dev, "Didn't find host pnor flash\n");
    > -				return -EINVAL;
    > +				dev_dbg(dev, "Didn't find host pnor flash\n");
    > +				return -ENXIO;
    >  			}
    >  			addr = lpc_ctrl->pnor_base;
    >  			size = lpc_ctrl->pnor_size;
    >  		} else if (map.window_type == ASPEED_LPC_CTRL_WINDOW_MEMORY) {
    >  			/* If memory-region is not described in device tree */
    >  			if (!lpc_ctrl->mem_size) {
    > -				dev_err(dev, "Didn't find reserved memory\n");
    > -				return -EINVAL;
    > +				dev_dbg(dev, "Didn't find reserved memory\n");
    > +				return -ENXIO;
    >  			}
    >  			addr = lpc_ctrl->mem_base;
    >  			size = lpc_ctrl->mem_size;
    > @@ -239,7 +239,7 @@ static int aspeed_lpc_ctrl_probe(struct 
    > platform_device *pdev)
    >  		of_node_put(node);
    >  		if (rc) {
    >  			dev_err(dev, "Couldn't address to resource for reserved memory\n");
    > -			return -ENOMEM;
    > +			return -ENXIO;
    >  		}
    >  
    >  		lpc_ctrl->mem_size = resource_size(&resm);
    > -- 
    > 2.17.1
    > 
    >
    

