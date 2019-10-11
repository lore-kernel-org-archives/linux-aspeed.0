From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Fri, 11 Oct 2019 14:10:44 +1100
Subject: [PATCH] ftgmac100: Disable HW checksum generation on AST2500
In-Reply-To: <AF7B985F-6E42-4CD4-B3D0-4B9EA42253C9@fb.com>
References: <20190910213734.3112330-1-vijaykhemka@fb.com>
 <bd5eab2e-6ba6-9e27-54d4-d9534da9d5f7@gmail.com>
 <CACPK8XcS4iKfKigPbPg0BFbmjbT-kdyjiPDXjk1k5XaS5bCdAA@mail.gmail.com>
 <95e215664612c0487808c02232852ef2188c95a5.camel@kernel.crashing.org>
 <AF7B985F-6E42-4CD4-B3D0-4B9EA42253C9@fb.com>
Message-ID: <158fa0872643089750b3797fd2f78ba18eaf488c.camel@kernel.crashing.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, 2019-10-10 at 19:15 +0000, Vijay Khemka wrote:
>     Any news on this ? AST2400 has no HW checksum logic in HW, AST2500
>     should work for IPV4 fine, we should only selectively disable it for
>     IPV6.
> 
> Ben, I have already sent v2 for this with requested change which only disable 
> for IPV6 in AST2500. I can send it again.

I didn't see it, did you CC me ? I maintain that driver...

Cheers,
Ben.


