Return-Path: <linux-aspeed+bounces-5187-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE5BBCC6B08
	for <linux-aspeed@archiver.kernel.org>; Tue, 13 Oct 2026 10:00:43 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j3qbF5S16z3br5;
	Tue, 13 Oct 2026 21:00:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791885641;
	cv=none; b=VOisfLVU7yG2yxNflehkOIh2Y9ZctfnVcsaNeQ2n9V8nAuJGyOjDdyG9Q6Pb5j6xWkPUT1QuvlOjkAZ/gXVT7Ta6NkXI10uppMuvi6fMnezvSmXN38jyZzatEDHK5kjOcAOZzX7g8ZM3jG3vftuP5pManxa1qLrRlHzbL24j8UEzdSfdhxFIqgwo27MD25WUlKGNXbE2KUU0ciTMlPJhy7gsIZz79bySkBAPWqOTSZP8QTuhDMQ+Zdbc9+nP3n5ROgyjys9QaJba/tRcjUq4s0Yy/1XL6Qw3dt+lQ40sMKjIpig8QuKdpCVx87lUitJUMwa07KGBbuwCvskt0BxlBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791885641; c=relaxed/relaxed;
	bh=pfdLP83mHPHFMso2iF2XtpyrYtYAJ695PtbO2PEHxYc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EgWAxz3Mm4HWlS7rGpH9kuma+e74vpk2R8Gyg/WB+GoNHcWol87qtVkREjxXKBSEkUzqb7SsyvafmEOfzhBw09KHk3Cj6ywDPmD46Pa57ofF6URZ7dh2GdS+TJ0jU8q9BV8tmISoJTLgiN/g82DZckbjew2rYjoRb0iw1BpBQazM0W0veG9yoVn6wzmWc01gBmC6HyNXzFbHfglTZrBNIbLnt4IUuPwlO8JssKlPo0uYMm/46x/73Yghz5fdlfR+2THF/wBdF5RsGCuCgy3zEWJDbs+f0IWZYYY2ol2mwRokQKKU7VJ14tQ79dO/+7HdwGW7U+yD+uuYVSLh58GbtA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=iP4mGtJM; dkim-atps=neutral; spf=pass (client-ip=198.175.65.21; helo=mgamail.intel.com; envelope-from=andriy.shevchenko@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=iP4mGtJM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=198.175.65.21; helo=mgamail.intel.com; envelope-from=andriy.shevchenko@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j3qbB2Cqyz30hC
	for <linux-aspeed@lists.ozlabs.org>; Tue, 13 Oct 2026 21:00:36 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791885638; x=1823421638;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fTGeNaBIaLCVqoO0T9Dn+Yn3xOiEnsjDiubugzTxCX0=;
  b=iP4mGtJMZS3dwy79odvS0+Kcidv427Twey5jP2GN0da1kYCNVDuvZH+Y
   /en6Bcw/us+PUB/BMeClojyB88xmtbTDUF3snozg9acIWP/NLRXHkhiCC
   2UTulSvv80/vUZEJ2BHDvJGbBzQwegd5T+Is5ScRgarkgGu20DNzaSmWh
   ZmCjiqlxI+punehLSK0NUiVa8s4WTljAJj204SEk+3UAxhOIa04l0ykgs
   ypjZBcVvYWV2VCJvNDYWePdKwfcL0WtQ6UZ92CzZEsAtVirhFJmPgKQR9
   at9BHFmwR+dOnizbkNaf6c6dyLBdpdXxRP1OaUeSwZB9u0+uSt2L2rt9Y
   Q==;
X-CSE-ConnectionGUID: LsELgBtVR4K0/vQYG4/pFw==
X-CSE-MsgGUID: jdugM4SWQeiDCvg9Z9cPPA==
X-IronPort-AV: E=McAfee;i="6800,10657,11933"; a="700905"
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="700905"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 03:00:31 -0700
X-CSE-ConnectionGUID: 1iNYISSoTuuhs5glB6ekBw==
X-CSE-MsgGUID: SGL4lvnmTw63CNrOzbER/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="1174167"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.48])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 03:00:18 -0700
Date: Tue, 13 Oct 2026 13:00:16 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Richard Cochran <richardcochran@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Ryan Chen <ryan_chen@aspeedtech.com>,
	Billy Tsai <billy_tsai@aspeedtech.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Ray Jui <ray.jui@broadcom.com>,
	Scott Branden <scott.branden@broadcom.com>,
	Al Cooper <alcooperx@gmail.com>,
	Paul Cercueil <paul@crapouillou.net>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Chaitanya Vadrevu <chaitanya.vadrevu@emerson.com>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	Helge Deller <deller@gmx.de>,
	Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>,
	Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Masami Hiramatsu <mhiramat@kernel.org>, Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-rpi-kernel@lists.infradead.org,
	linux-mips@vger.kernel.org, linux-mediatek@lists.infradead.org,
	linux-parisc@vger.kernel.org, linux-tegra@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 6/6] serial: 8250: make port operations work on struct
 uart_8250_port
Message-ID: <as4BML-VUC9xUgOf@ashevche-desk.local>
References: <cover.1791873876.git.jirislaby@kernel.org>
 <c59fa203f325e0fe7601ea0fbc0d222c8b37f9eb.1791873876.git.jirislaby@kernel.org>
 <as3etnbZatn4sbfx@ashevche-desk.local>
 <c6b08f53-b5ee-44c8-93d1-54fdf5994ed2@kernel.org>
 <as31PsESOgLUhMB6@ashevche-desk.local>
 <b404f3d7-1b2d-418a-8634-72c61ce33f8b@kernel.org>
X-Mailing-List: linux-aspeed@lists.ozlabs.org
List-Id: <linux-aspeed.lists.ozlabs.org>
List-Help: <mailto:linux-aspeed+help@lists.ozlabs.org>
List-Owner: <mailto:linux-aspeed+owner@lists.ozlabs.org>
List-Post: <mailto:linux-aspeed@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linux-aspeed/>,
  <https://lists.ozlabs.org/pipermail/linux-aspeed/>
List-Subscribe: <mailto:linux-aspeed+subscribe@lists.ozlabs.org>,
  <mailto:linux-aspeed+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-aspeed+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-aspeed+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b404f3d7-1b2d-418a-8634-72c61ce33f8b@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Oct 13, 2026 at 11:39:00AM +0200, Jiri Slaby wrote:
> On 13. 10. 26, 11:09, Andy Shevchenko wrote:
> > On Tue, Oct 13, 2026 at 09:53:26AM +0200, Jiri Slaby wrote:
> > > On 13. 10. 26, 9:33, Andy Shevchenko wrote:
> > > > On Tue, Oct 13, 2026 at 08:48:51AM +0200, Jiri Slaby (SUSE) wrote:

...

> > > > > -	rc = serial8250_register_8250_port(&port);
> > > > > -	if (rc < 0)
> > > > > +	struct uart_8250_port *uport = serial8250_register_8250_port(&port);
> > > > > +	if (IS_ERR(uport)) {
> > > > > +		rc = PTR_ERR(uport);
> > > > >    		goto err_sysfs_remove;
> > > > > +	}
> > > 
> > > > Also do not define
> > > > variables in the middle of the code (it's only allowed for auto cleanup
> > > > variables and for-loop iterators).
> > > 
> > > Why, actually?
> > 
> > Because it's the style.
> 
> There is no hard style though. It varies across subsystems.

The keyword is *slightly*. I do not see much of deviation in style in the
subsystem maintainer-XXX.rst. Do you?

> > Linus also told it many times
> 
> Which is neither an argument. Linus is wrong at times ("Link:" use as an
> example).

Link is different, it wasn't about the code. So, for coding style we have stricter
rules.

> All in all, I do not insist on this at all. It's easier to read and follow
> the code for me. Not necessarily the case for others...

> > > First, it is used in the kernel quite a few times already
> > > [1]. Second, while it is sort of c++ism (and I like to use modern c++), it
> > > makes the life of the variable a lot more obvious.
> > > 
> > > [1] eg. see output of: rg -U -C 5 '}\n+\s+struct .*\*.*=' drivers/
> > 
> > (you made me to install something I haven't heard about, it's better to use
> >   `git grep` though)
> 
> rg is order of magnitude faster (searches in parallel). More importantly in
> this case, supports multiline matches. (And respects .git ignores.)

Isn't `git grep` fast enough due to looking into index and not into the files?
`rg` may not look at the Git index, right? So I may not to use an arbitrary
hash without checking it out first.

> > Note excluded __free() if I get regexp correctly
> > 
> > $ rg -U -l '}\n+\s+struct .*\*[^)]*=' drivers/ | less
> > drivers/ufs/host/ufs-qcom.c
> ...
> > drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> > 
> > So, less than dozen of drivers doing wrong is not an argument, try something
> > better. But thanks, I will check and address this in some of the above.
> 
> Well, it's only an example of a declaration after a previous opening brace
> "{" -- this one turned out to be easy to search for. There is a lot of more,
> of course. kernel/ included.

Please, provide a better search line, I will look at that. For now it's just
a hypothetical assumption, I am afraid.

-- 
With Best Regards,
Andy Shevchenko



