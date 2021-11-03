From: Jakub Kicinski <kuba@kernel.org>
Date: Wed, 3 Nov 2021 09:16:20 -0700
Subject: [PATCH v4] Add payload to be 32-bit aligned to fix dropped packets
In-Reply-To: <CAA7Tbcu7rOxhP45m0tkQBKWxUFGwtQ3Z485wyCtS-wVaTtq2=g@mail.gmail.com>
References: <20211028095047.GA15236@gmail.com>
 <CAA7TbctGtHBuVOsamFH1sQq_C5BvtsRyCM+b0Z7W=fS_eb8ATA@mail.gmail.com>
 <20211103084939.04f6813f@kicinski-fedora-PC1C0HJN>
 <CAA7Tbcu7rOxhP45m0tkQBKWxUFGwtQ3Z485wyCtS-wVaTtq2=g@mail.gmail.com>
Message-ID: <20211103091620.718b4e11@kicinski-fedora-PC1C0HJN>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, 3 Nov 2021 21:43:03 +0530 Kumar Thangavel wrote:
> Hi Jakub,
> 
> Thanks for your response.
> 
> Somehow, My mails are not delivered to netdev at vger.kernel.org.
> 
> So, I removed it in my last 2 patchsets.
> 
> I will try again to CCing netdev at vger.kernel.org.

For normal replies you need to use plain text, not HTML. The mailing
list rejects HTML emails. But the patch should go thru, we'll see.
