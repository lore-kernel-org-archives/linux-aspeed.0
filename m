From: Vijay Khemka <vijaykhemka@fb.com>
Date: Fri, 25 Oct 2019 19:11:21 +0000
Subject: [PATCH] net: ethernet: ftgmac100: Fix DMA coherency issue with SW
 checksum
In-Reply-To: <572a7d510ace5e5a5ba41c4774d330133291c82a.camel@kernel.crashing.org>
References: <572a7d510ace5e5a5ba41c4774d330133291c82a.camel@kernel.crashing.org>
Message-ID: <672FAA6F-5DA7-4AA7-A049-96DF82CEEA18@fb.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Looks good to me. And I have tested it. It works perfectly fine.

Reviewed-by: Vijay Khemka <vijaykhemka@fb.com>
Tested-by: Vijay Khemka <vijaykhemka@fb.com>

?On 10/24/19, 7:47 PM, "Benjamin Herrenschmidt" <benh@kernel.crashing.org> wrote:

    We are calling the checksum helper after the dma_map_single()
    call to map the packet. This is incorrect as the checksumming
    code will touch the packet from the CPU. This means the cache
    won't be properly flushes (or the bounce buffering will leave
    us with the unmodified packet to DMA).
    
    This moves the calculation of the checksum & vlan tags to
    before the DMA mapping.
    
    This also has the side effect of fixing another bug: If the
    checksum helper fails, we goto "drop" to drop the packet, which
    will not unmap the DMA mapping.
    
    Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
    Fixes: 05690d633f30 ftgmac100: Upgrade to NETIF_F_HW_CSUM
    CC: stable at vger.kernel.org [v4.12+]
    ---
     drivers/net/ethernet/faraday/ftgmac100.c | 25 ++++++++++++------------
     1 file changed, 12 insertions(+), 13 deletions(-)
    
    diff --git a/drivers/net/ethernet/faraday/ftgmac100.c b/drivers/net/ethernet/faraday/ftgmac100.c
    index 9b7af94a40bb..96e9565f1e08 100644
    --- a/drivers/net/ethernet/faraday/ftgmac100.c
    +++ b/drivers/net/ethernet/faraday/ftgmac100.c
    @@ -727,6 +727,18 @@ static netdev_tx_t ftgmac100_hard_start_xmit(struct sk_buff *skb,
     	 */
     	nfrags = skb_shinfo(skb)->nr_frags;
     
    +	/* Setup HW checksumming */
    +	csum_vlan = 0;
    +	if (skb->ip_summed == CHECKSUM_PARTIAL &&
    +	    !ftgmac100_prep_tx_csum(skb, &csum_vlan))
    +		goto drop;
    +
    +	/* Add VLAN tag */
    +	if (skb_vlan_tag_present(skb)) {
    +		csum_vlan |= FTGMAC100_TXDES1_INS_VLANTAG;
    +		csum_vlan |= skb_vlan_tag_get(skb) & 0xffff;
    +	}
    +
     	/* Get header len */
     	len = skb_headlen(skb);
     
    @@ -753,19 +765,6 @@ static netdev_tx_t ftgmac100_hard_start_xmit(struct sk_buff *skb,
     	if (nfrags == 0)
     		f_ctl_stat |= FTGMAC100_TXDES0_LTS;
     	txdes->txdes3 = cpu_to_le32(map);
    -
    -	/* Setup HW checksumming */
    -	csum_vlan = 0;
    -	if (skb->ip_summed == CHECKSUM_PARTIAL &&
    -	    !ftgmac100_prep_tx_csum(skb, &csum_vlan))
    -		goto drop;
    -
    -	/* Add VLAN tag */
    -	if (skb_vlan_tag_present(skb)) {
    -		csum_vlan |= FTGMAC100_TXDES1_INS_VLANTAG;
    -		csum_vlan |= skb_vlan_tag_get(skb) & 0xffff;
    -	}
    -
     	txdes->txdes1 = cpu_to_le32(csum_vlan);
     
     	/* Next descriptor */
    
    
    

