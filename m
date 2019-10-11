From: Vijay Khemka <vijaykhemka@fb.com>
Date: Fri, 11 Oct 2019 21:28:36 +0000
Subject: [PATCH] ftgmac100: Disable HW checksum generation on AST2500
In-Reply-To: <158fa0872643089750b3797fd2f78ba18eaf488c.camel@kernel.crashing.org>
References: <20190910213734.3112330-1-vijaykhemka@fb.com>
 <bd5eab2e-6ba6-9e27-54d4-d9534da9d5f7@gmail.com>
 <CACPK8XcS4iKfKigPbPg0BFbmjbT-kdyjiPDXjk1k5XaS5bCdAA@mail.gmail.com>
 <95e215664612c0487808c02232852ef2188c95a5.camel@kernel.crashing.org>
 <AF7B985F-6E42-4CD4-B3D0-4B9EA42253C9@fb.com>
 <158fa0872643089750b3797fd2f78ba18eaf488c.camel@kernel.crashing.org>
Message-ID: <AD92CCF8-91B2-4EA1-9915-812D701E9CFA@fb.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



?On 10/10/19, 8:11 PM, "Benjamin Herrenschmidt" <benh@kernel.crashing.org> wrote:

    On Thu, 2019-10-10 at 19:15 +0000, Vijay Khemka wrote:
    >     Any news on this ? AST2400 has no HW checksum logic in HW, AST2500
    >     should work for IPV4 fine, we should only selectively disable it for
    >     IPV6.
    > 
    > Ben, I have already sent v2 for this with requested change which only disable 
    > for IPV6 in AST2500. I can send it again.
    
    I didn't see it, did you CC me ? I maintain that driver...

Let me send again via git send-email.
    
    Cheers,
    Ben.
    
    
    

