From: Joel Stanley <joel@jms.id.au>
Date: Thu, 16 Sep 2021 03:52:24 +0000
Subject: [v5 04/15] iio: adc: aspeed: Keep model data to driver data.
In-Reply-To: <20210905155029.3faa2c04@jic23-huawei>
References: <20210831071458.2334-1-billy_tsai@aspeedtech.com>
 <20210831071458.2334-5-billy_tsai@aspeedtech.com>
 <20210905153339.751732cc@jic23-huawei>
 <20210905155029.3faa2c04@jic23-huawei>
Message-ID: <CACPK8Xe4KifkDxm0H6LtpCJZ1n07GLvxR_nF4Cfy5+4WXn9Z6g@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Sun, 5 Sept 2021 at 14:47, Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Sun, 5 Sep 2021 15:33:39 +0100
> Jonathan Cameron <jic23@kernel.org> wrote:
>
> > On Tue, 31 Aug 2021 15:14:47 +0800
> > Billy Tsai <billy_tsai@aspeedtech.com> wrote:
> >
> > > Keep the model data pointer to driver data for reducing the usage of
> > > of_device_get_match_data().
> > >
> > > Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
> > This one starts to be impacted by the fix (as its in the context).
> > Rather than making a mess of things for linux-next etc I'll hold
> > off on these until that fix is upstream in a few weeks.
> >
> > If I seem to have lost it (it's been known to happen :( ) then
> > feel free to poke me!
>
> Having taken another look at the rest of the series (and Philipp's review)
> please do a v6 starting from this patch.

I'd recommend against the practice of half applying a series. I have
just spent a good chunk of time looking at v6, and wondering why it
won't apply to any tags in Linus tree nor to next.

(It was made worse by the branch you applied them to not being part of
linux-next.)

Cheers,

Joel
