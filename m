From: Jonathan Cameron <jic23@kernel.org>
Date: Mon, 24 Jun 2024 20:34:26 +0100
Subject: [PATCH 00/10] iio: use devm_regulator_get_enable_read_voltage
 round 2
In-Reply-To: <20240623111247.1c4a5e2a@jic23-huawei>
References: <20240621-iio-regulator-refactor-round-2-v1-0-49e50cd0b99a@baylibre.com>
	<20240623111247.1c4a5e2a@jic23-huawei>
Message-ID: <20240624203426.1970ec62@jic23-huawei>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Sun, 23 Jun 2024 11:12:47 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Fri, 21 Jun 2024 17:11:47 -0500
> David Lechner <dlechner@baylibre.com> wrote:
> 
> > This is the second round of patches making use of the new helper
> > devm_regulator_get_enable_read_voltage() to simplify drivers.
> > 
> > All of the changes in this round should be fairly straight forward.
> > And as a bonus, there are a few patches to get rid of driver .remove
> > callbacks.  
> 
> LGTM.  Obviously only been on list for a short time though and
> some of these have active maintainers so I won't pick them up just yet.

I think most of the people I thought would review did super quick so 
applied.

Thanks,

Jonathan

> 
> Jonathan
> 
> > 
> > ---
> > David Lechner (10):
> >       iio: adc: aspeed_adc: use devm_regulator_get_enable_read_voltage()
> >       iio: adc: hx711: use devm_regulator_get_enable_read_voltage()
> >       iio: adc: hx711: remove hx711_remove()
> >       iio: adc: hx711: use dev_err_probe()
> >       iio: adc: ltc2309: use devm_regulator_get_enable_read_voltage()
> >       iio: adc: max1363: use devm_regulator_get_enable_read_voltage()
> >       iio: adc: ti-adc108s102: use devm_regulator_get_enable_read_voltage()
> >       iio: adc: ti-ads8688: use devm_regulator_get_enable_read_voltage()
> >       iio: adc: ti-ads8688: drop ads8688_remove()
> >       iio: dac: ad3552r: use devm_regulator_get_enable_read_voltage()
> > 
> >  drivers/iio/adc/aspeed_adc.c    | 30 +++++-----------
> >  drivers/iio/adc/hx711.c         | 78 ++++++++++-------------------------------
> >  drivers/iio/adc/ltc2309.c       | 43 ++++-------------------
> >  drivers/iio/adc/max1363.c       | 28 +++------------
> >  drivers/iio/adc/ti-adc108s102.c | 28 ++-------------
> >  drivers/iio/adc/ti-ads8688.c    | 59 ++++++-------------------------
> >  drivers/iio/dac/ad3552r.c       | 28 +++------------
> >  7 files changed, 53 insertions(+), 241 deletions(-)
> > ---
> > base-commit: 7db8a847f98caae68c70bdab9ba92d1af38e5656
> > change-id: 20240621-iio-regulator-refactor-round-2-28a1e129a42d  
> 
> 

