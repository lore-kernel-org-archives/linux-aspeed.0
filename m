From: Vijay Khemka <vijaykhemka@fb.com>
Date: Wed, 11 Sep 2019 17:48:28 +0000
Subject: [PATCH 1/4] gpio/aspeed: Fix incorrect number of banks
In-Reply-To: <20190904061245.30770-1-rashmica.g@gmail.com>
References: <20190904061245.30770-1-rashmica.g@gmail.com>
Message-ID: <39AE527D-F629-4AD7-980C-61C55C5B8718@fb.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



?On 9/11/19, 5:16 AM, "Linux-aspeed on behalf of Rashmica Gupta" <linux-aspeed-bounces+vijaykhemka=fb.com at lists.ozlabs.org on behalf of rashmica.g@gmail.com> wrote:

    Fixes: 361b79119a4b7 ('gpio: Add Aspeed driver')
    
    Signed-off-by: Rashmica Gupta <rashmica.g@gmail.com>
    ---
     drivers/gpio/gpio-aspeed.c | 2 +-
     1 file changed, 1 insertion(+), 1 deletion(-)
    
    diff --git a/drivers/gpio/gpio-aspeed.c b/drivers/gpio/gpio-aspeed.c
    index 9defe25d4721..77752b2624e8 100644
    --- a/drivers/gpio/gpio-aspeed.c
    +++ b/drivers/gpio/gpio-aspeed.c
    @@ -1165,7 +1165,7 @@ static int __init aspeed_gpio_probe(struct platform_device *pdev)
     	gpio->chip.base = -1;
     
     	/* Allocate a cache of the output registers */
    -	banks = gpio->config->nr_gpios >> 5;
    +	banks = (gpio->config->nr_gpios >> 5) + 1;
If number of gpios are 32 then it should be only 1 bank, as per above it is 2 bank.
     	gpio->dcache = devm_kcalloc(&pdev->dev,
     				    banks, sizeof(u32), GFP_KERNEL);
     	if (!gpio->dcache)
    -- 
    2.20.1
    
    

