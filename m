From: Vijay Khemka <vijaykhemka@fb.com>
Date: Sat, 19 Oct 2019 01:31:45 +0000
Subject: [PATCH v2] ftgmac100: Disable HW checksum generation on AST2500
In-Reply-To: <0ef567e985ce3fe821cbd80265f85a35d16be373.camel@kernel.crashing.org>
References: <20191011213027.2110008-1-vijaykhemka@fb.com>
 <3a1176067b745fddfc625bbd142a41913ee3e3a1.camel@kernel.crashing.org>
 <0C0BC813-5A84-403F-9C48-9447AAABD867@fb.com>
 <071cf1eeefcbfc14633a13bc2d15ad7392987a88.camel@kernel.crashing.org>
 <9AA81274-01F2-4803-8905-26F0521486CE@fb.com>
 <f6d5cb45a9aa167533135c5b218b45b1d210d31a.camel@kernel.crashing.org>
 <529EF9B4-DFDE-4DB7-BE26-3AED8D814134@fb.com>
 <0ef567e985ce3fe821cbd80265f85a35d16be373.camel@kernel.crashing.org>
Message-ID: <3D78AA04-A502-4A9F-87A0-0D62D56952AF@fb.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



?On 10/18/19, 5:03 PM, "Benjamin Herrenschmidt" <benh@kernel.crashing.org> wrote:

    On Fri, 2019-10-18 at 22:50 +0000, Vijay Khemka wrote:
    > I don't have much understanding of IP Stack but I went through code details and 
    > you are right and found that it should fallback to SW calculation for IPV6 but it doesn't
    > happen because ftgmac100_hard_start_xmit checks for CHECKSUM_PARTIAL before
    > setting HW checksum and calling ftgmac100_prep_tx_csum function. And in my 
    > understanding, this value is set CHECKSUM_PARTIAL in IP stack. I looked up IP stack for
    > IPV6, file net/ipv6/ip6_output.c, function __ip6_append_data: here it sets 
    > CHECKSUM_PARTIAL only for UDP packets not for TCP packets. Please look at line
    >  number 1880. This could be an issue we are seeing here as why
    > ftgmac100_prep_tx_csum is not getting triggered for IPV6 with TCP. Please correct
    > me if my understanding is wrong.
    >     
    
    Not entirely sure. tcp_v6_send_response() in tcp_ipv6.c does set
    CHECKSUM_PARTIAL as well. I don't really know how things are being
    handled in that part of the network stack though.
    
    From a driver perspective, if the value of ip_summed is not
    CHECKSUM_PARTIAL it means we should not have to calculate any checksum.
    At least that's my understanding here.
    
    You may need to add some traces to the driver to see what you get in
    there, what protocol indication etc... and analyze the corresponding
    packets with something like tcpdump or wireshark on the other end.

Thanks Ben,
I will try to add some trace and test whatever possible and test it. As we
don't have tcpdump into our image and I have limited understanding of
networking stack so if you get some time to verify ipv6, it will be really
helpful. 
    
    Cheers,
    Ben.
    
    
    

