From: Joel Stanley <joel@jms.id.au>
Date: Wed, 2 Oct 2019 22:05:32 +0000
Subject: [PATCH 0/2] peci: aspeed: Add AST2600 compatible
In-Reply-To: <70044749-785b-6ff3-7a28-fb049dcfec54@linux.intel.com>
References: <20191002061200.29888-1-chiawei_wang@aspeedtech.com>
 <70044749-785b-6ff3-7a28-fb049dcfec54@linux.intel.com>
Message-ID: <CACPK8XfBxC+4PHHCkMoXr+twjfWaovcJ5c=hfCmHRJ6LpGNeFg@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, 2 Oct 2019 at 18:11, Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com> wrote:
>
> Hi Chia-Wei,
>
> On 10/1/2019 11:11 PM, Chia-Wei, Wang wrote:
> > Update the Aspeed PECI driver with the AST2600 compatible string.
> > A new comptabile string is needed for the extended HW feature of
> > AST2600.
> >
> > Chia-Wei, Wang (2):
> >    peci: aspeed: Add AST2600 compatible string
> >    dt-bindings: peci: aspeed: Add AST2600 compatible
> >
> >   Documentation/devicetree/bindings/peci/peci-aspeed.txt | 1 +
> >   drivers/peci/peci-aspeed.c                             | 1 +
> >   2 files changed, 2 insertions(+)
> >
>
> PECI subsystem isn't in linux upstream yet so you should submit it into
> OpenBMC dev-5.3 tree only.

OpenBMC has been carrying the out of tree patches for some time now. I
haven't seen a new version posted for a while. Do you have a timeline
for when you plan to submit it upstream?
