From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Fri, 18 Oct 2019 10:34:57 +1100
Subject: [PATCH v2] ftgmac100: Disable HW checksum generation on AST2500
In-Reply-To: <071cf1eeefcbfc14633a13bc2d15ad7392987a88.camel@kernel.crashing.org>
References: <20191011213027.2110008-1-vijaykhemka@fb.com>
 <3a1176067b745fddfc625bbd142a41913ee3e3a1.camel@kernel.crashing.org>
 <0C0BC813-5A84-403F-9C48-9447AAABD867@fb.com>
 <071cf1eeefcbfc14633a13bc2d15ad7392987a88.camel@kernel.crashing.org>
Message-ID: <b99afb6c88f00279c68979f344a15a2c200ca67e.camel@kernel.crashing.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, 2019-10-18 at 10:14 +1100, Benjamin Herrenschmidt wrote:
> 
> I don't understand what you are saying. You reported a problem with
> IPV6 checksums generation. The HW doesn't support it. What's "not a
> matter of unsupported csum" ?
> 
> Your patch uses a *deprecated* bit to tell the network stack to only do
> HW checksum generation on IPV4.
> 
> This bit is deprecated for a reason, again, see skbuff.h. The right
> approach, *which the driver already does*, is to tell the stack that we
> support HW checksuming using NETIF_F_HW_CSUM, and then, in the transmit
> handler, to call skb_checksum_help() to have the SW calculate the
> checksum if it's not a supported type.
> 
> This is exactly what ftgmac100_prep_tx_csum() does. It only enables HW
> checksum generation on supported types and uses skb_checksum_help()
> otherwise, supported types being protocol ETH_P_IP and IP protocol
> being raw IP, TCP and UDP.
> 
> So this *should* have fallen back to SW for IPV6. So either something
> in my code there is making an incorrect assumption, or something is
> broken in skb_checksum_help() for IPV6 (which I somewhat doubt) or
> something else I can't think of, but setting a *deprecated* flag is
> definitely not the right answer, neither is completely disabling HW
> checksumming.
> 
> So can you investigate what's going on a bit more closely please ? I
> can try myself, though I have very little experience with IPV6 and
> probably won't have time before next week.

I did get that piece of information from Aspeed: The HW checksum
generation is supported if:

 - The length of UDP header is always 20 bytes.
 - The length of TCP and IP header have 4 * N bytes (N is 5 to 15).

Now these afaik are also the protocol limits, so it *should* work.

Or am I missing something or some funky encaspulation/header format
that can be used under some circumstances ?

Cheers,
Ben.


