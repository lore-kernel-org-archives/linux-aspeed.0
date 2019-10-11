From: Jakub Kicinski <jakub.kicinski@netronome.com>
Date: Thu, 10 Oct 2019 18:16:51 -0700
Subject: [PATCH v2] ftgmac100: Disable HW checksum generation on AST2500
In-Reply-To: <4B7340B5-C35C-4B18-8D8C-B5B8D16BA551@fb.com>
References: <20190911194453.2595021-1-vijaykhemka@fb.com>
 <4B7340B5-C35C-4B18-8D8C-B5B8D16BA551@fb.com>
Message-ID: <20191010181651.5abd4c21@cakuba.netronome.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, 10 Oct 2019 19:20:47 +0000, Vijay Khemka wrote:
> Resending this patch again. 

Perhaps I'm missing context but what's the intention here?

In case this is resubmitting the patch for inclusion in the upstream
kernel you need to send it out properly with git send-email or such..

> ?On 9/11/19, 1:05 PM, "Vijay Khemka" <vijaykhemka@fb.com> wrote:
> 
>     HW checksum generation is not working for AST2500, specially with IPV6
>     over NCSI. All TCP packets with IPv6 get dropped. By disabling this
>     it works perfectly fine with IPV6. As it works for IPV4 so enabled
>     hw checksum back for IPV4.
>     
>     Verified with IPV6 enabled and can do ssh.
>     
>     Signed-off-by: Vijay Khemka <vijaykhemka@fb.com>
