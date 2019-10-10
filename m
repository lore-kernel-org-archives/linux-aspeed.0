From: Vijay Khemka <vijaykhemka@fb.com>
Date: Thu, 10 Oct 2019 19:20:47 +0000
Subject: [PATCH v2] ftgmac100: Disable HW checksum generation on AST2500
In-Reply-To: <20190911194453.2595021-1-vijaykhemka@fb.com>
References: <20190911194453.2595021-1-vijaykhemka@fb.com>
Message-ID: <4B7340B5-C35C-4B18-8D8C-B5B8D16BA551@fb.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Resending this patch again. 

?On 9/11/19, 1:05 PM, "Vijay Khemka" <vijaykhemka@fb.com> wrote:

    HW checksum generation is not working for AST2500, specially with IPV6
    over NCSI. All TCP packets with IPv6 get dropped. By disabling this
    it works perfectly fine with IPV6. As it works for IPV4 so enabled
    hw checksum back for IPV4.
    
    Verified with IPV6 enabled and can do ssh.
    
    Signed-off-by: Vijay Khemka <vijaykhemka@fb.com>
    ---
    Changes since v1:
     Enabled IPV4 hw checksum generation as it works for IPV4.
    
     drivers/net/ethernet/faraday/ftgmac100.c | 13 ++++++++++++-
     1 file changed, 12 insertions(+), 1 deletion(-)
    
    diff --git a/drivers/net/ethernet/faraday/ftgmac100.c b/drivers/net/ethernet/faraday/ftgmac100.c
    index 030fed65393e..0255a28d2958 100644
    --- a/drivers/net/ethernet/faraday/ftgmac100.c
    +++ b/drivers/net/ethernet/faraday/ftgmac100.c
    @@ -1842,8 +1842,19 @@ static int ftgmac100_probe(struct platform_device *pdev)
     	/* AST2400  doesn't have working HW checksum generation */
     	if (np && (of_device_is_compatible(np, "aspeed,ast2400-mac")))
     		netdev->hw_features &= ~NETIF_F_HW_CSUM;
    +
    +	/* AST2500 doesn't have working HW checksum generation for IPV6
    +	 * but it works for IPV4, so disabling hw checksum and enabling
    +	 * it for only IPV4.
    +	 */
    +	if (np && (of_device_is_compatible(np, "aspeed,ast2500-mac"))) {
    +		netdev->hw_features &= ~NETIF_F_HW_CSUM;
    +		netdev->hw_features |= NETIF_F_IP_CSUM;
    +	}
    +
     	if (np && of_get_property(np, "no-hw-checksum", NULL))
    -		netdev->hw_features &= ~(NETIF_F_HW_CSUM | NETIF_F_RXCSUM);
    +		netdev->hw_features &= ~(NETIF_F_HW_CSUM | NETIF_F_RXCSUM
    +					 | NETIF_F_IP_CSUM);
     	netdev->features |= netdev->hw_features;
     
     	/* register network device */
    -- 
    2.17.1
    
    

