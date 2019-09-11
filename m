From: Florian Fainelli <f.fainelli@gmail.com>
Date: Wed, 11 Sep 2019 11:34:24 -0700
Subject: [PATCH] ftgmac100: Disable HW checksum generation on AST2500
In-Reply-To: <8A8392C8-5E5E-444D-AB1B-E0FAD3C29425@fb.com>
References: <20190910213734.3112330-1-vijaykhemka@fb.com>
 <bd5eab2e-6ba6-9e27-54d4-d9534da9d5f7@gmail.com>
 <0797B1F1-883D-4129-AC16-794957ACCF1B@fb.com>
 <D79D04CC-4A02-4E51-8FDF-48B7C7EB6CC2@fb.com>
 <8A8392C8-5E5E-444D-AB1B-E0FAD3C29425@fb.com>
Message-ID: <c9876340-c8d0-ba8b-2ae1-9900958f1834@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 9/11/19 11:30 AM, Vijay Khemka wrote:
> 
> 
> ?On 9/10/19, 4:08 PM, "Linux-aspeed on behalf of Vijay Khemka" <linux-aspeed-bounces+vijaykhemka=fb.com at lists.ozlabs.org on behalf of vijaykhemka@fb.com> wrote:
> 
>     
>     
>     On 9/10/19, 3:50 PM, "Linux-aspeed on behalf of Vijay Khemka" <linux-aspeed-bounces+vijaykhemka=fb.com at lists.ozlabs.org on behalf of vijaykhemka@fb.com> wrote:
>     
>         
>         
>         On 9/10/19, 3:05 PM, "Florian Fainelli" <f.fainelli@gmail.com> wrote:
>         
>             On 9/10/19 2:37 PM, Vijay Khemka wrote:
>             > HW checksum generation is not working for AST2500, specially with IPV6
>             > over NCSI. All TCP packets with IPv6 get dropped. By disabling this
>             > it works perfectly fine with IPV6.
>             > 
>             > Verified with IPV6 enabled and can do ssh.
>             
>             How about IPv4, do these packets have problem? If not, can you continue
>             advertising NETIF_F_IP_CSUM but take out NETIF_F_IPV6_CSUM?
>         
>         I changed code from (netdev->hw_features &= ~NETIF_F_HW_CSUM) to 
>         (netdev->hw_features &= ~NETIF_F_ IPV6_CSUM). And it is not working. 
>         Don't know why. IPV4 works without any change but IPv6 needs HW_CSUM
>         Disabled.
>     
>     Now I changed to
>     netdev->hw_features &= (~NETIF_F_HW_CSUM) | NETIF_F_IP_CSUM;
>     And it works.
> 
> I investigated more on these features and found that we cannot set NETIF_F_IP_CSUM 
> While NETIF_F_HW_CSUM is set. So I disabled NETIF_F_HW_CSUM first and enabled
> NETIF_F_IP_CSUM in next statement. And it works fine.
> 
> But as per line 166 in include/linux/skbuff.h,  
> *   NETIF_F_IP_CSUM and NETIF_F_IPV6_CSUM are being deprecated in favor of
>  *   NETIF_F_HW_CSUM. New devices should use NETIF_F_HW_CSUM to indicate
>  *   checksum offload capability.
> 
> Please suggest which of below 2 I should do. As both works for me.
> 1. Disable completely NETIF_F_HW_CSUM and do nothing. This is original patch.
> 2. Enable NETIF_F_IP_CSUM in addition to 1. I can have v2 if this is accepted.

Sounds like 2 would leave the option of offloading IPv4 checksum
offload, so that would be a better middle group than flat out disable
checksum offload for both IPv4 and IPv6, no?
-- 
Florian
