From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 21 Oct 2020 11:00:08 +1100
Subject: [PATCH] net: ftgmac100: Ensure tx descriptor updates are visible
In-Reply-To: <20201020220639.130696-1-joel@jms.id.au>
References: <20201020220639.130696-1-joel@jms.id.au>
Message-ID: <86480db3977cfbf6750209c34a28c8f042be55fb.camel@kernel.crashing.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, 2020-10-21 at 08:36 +1030, Joel Stanley wrote:
> We must ensure the tx descriptor updates are visible before updating
> the tx pointer.
> 
> This resolves the tx hangs observed on the 2600 when running iperf:

To clarify the comment here. This doesn't ensure they are visible to
the hardware but to other CPUs. This is the ordering vs start_xmit and
tx_complete.

Cheers,
Ben.

> root at ast2600:~# iperf3 -c 192.168.86.146 -R
> Connecting to host 192.168.86.146, port 5201
> Reverse mode, remote host 192.168.86.146 is sending
> [  5] local 192.168.86.173 port 43886 connected to 192.168.86.146
> port 5201
> [ ID] Interval           Transfer     Bitrate
> [  5]   0.00-1.00   sec  90.7 MBytes   760 Mbits/sec
> [  5]   1.00-2.00   sec  91.7 MBytes   769 Mbits/sec
> [  5]   2.00-3.00   sec  91.7 MBytes   770 Mbits/sec
> [  5]   3.00-4.00   sec  91.7 MBytes   769 Mbits/sec
> [  5]   4.00-5.00   sec  91.8 MBytes   771 Mbits/sec
> [  5]   5.00-6.00   sec  91.8 MBytes   771 Mbits/sec
> [  5]   6.00-7.00   sec  91.9 MBytes   771 Mbits/sec
> [  5]   7.00-8.00   sec  91.4 MBytes   767 Mbits/sec
> [  5]   8.00-9.00   sec  91.3 MBytes   766 Mbits/sec
> [  5]   9.00-10.00  sec  91.9 MBytes   771 Mbits/sec
> [  5]  10.00-11.00  sec  91.8 MBytes   770 Mbits/sec
> [  5]  11.00-12.00  sec  91.8 MBytes   770 Mbits/sec
> [  5]  12.00-13.00  sec  90.6 MBytes   761 Mbits/sec
> [  5]  13.00-14.00  sec  45.2 KBytes   370 Kbits/sec
> [  5]  14.00-15.00  sec  0.00 Bytes  0.00 bits/sec
> [  5]  15.00-16.00  sec  0.00 Bytes  0.00 bits/sec
> [  5]  16.00-17.00  sec  0.00 Bytes  0.00 bits/sec
> [  5]  17.00-18.00  sec  0.00 Bytes  0.00 bits/sec
> [   67.031671] ------------[ cut here ]------------
> [   67.036870] WARNING: CPU: 1 PID: 0 at net/sched/sch_generic.c:442
> dev_watchdog+0x2dc/0x300
> [   67.046123] NETDEV WATCHDOG: eth2 (ftgmac100): transmit queue 0
> timed out
> 
> Fixes: 52c0cae87465 ("ftgmac100: Remove tx descriptor accessors")
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
>  drivers/net/ethernet/faraday/ftgmac100.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/net/ethernet/faraday/ftgmac100.c
> b/drivers/net/ethernet/faraday/ftgmac100.c
> index 331d4bdd4a67..15cdfeb135b0 100644
> --- a/drivers/net/ethernet/faraday/ftgmac100.c
> +++ b/drivers/net/ethernet/faraday/ftgmac100.c
> @@ -653,6 +653,11 @@ static bool ftgmac100_tx_complete_packet(struct
> ftgmac100 *priv)
>  	ftgmac100_free_tx_packet(priv, pointer, skb, txdes, ctl_stat);
>  	txdes->txdes0 = cpu_to_le32(ctl_stat & priv-
> >txdes0_edotr_mask);
>  
> +	/* Ensure the descriptor config is visible before setting the
> tx
> +	 * pointer.
> +	 */
> +	smp_wmb();
> +
>  	priv->tx_clean_pointer = ftgmac100_next_tx_pointer(priv,
> pointer);
>  
>  	return true;
> @@ -806,6 +811,11 @@ static netdev_tx_t
> ftgmac100_hard_start_xmit(struct sk_buff *skb,
>  	dma_wmb();
>  	first->txdes0 = cpu_to_le32(f_ctl_stat);
>  
> +	/* Ensure the descriptor config is visible before setting the
> tx
> +	 * pointer.
> +	 */
> +	smp_wmb();
> +
>  	/* Update next TX pointer */
>  	priv->tx_pointer = pointer;
>  

