Return-Path: <linux-aspeed+bounces-3835-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CFBFE7E37D
	for <linux-aspeed@archiver.kernel.org>; Fri,  3 Apr 2026 11:56:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fnHJ55QTRz2ygT;
	Fri, 03 Apr 2026 22:56:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775217397;
	cv=none; b=bTkA0IEa2STmN3891/jeuJDu1q+h04/vypqJqESPA8IpRaQqxXUoC0XXwvrBn8sVm3+r0DcD68yBuolRqPq4RUzIVQDSYGoNoiCD74hJG3HDjaJokrdon3Je7E/LT0mVO4sGFwKzVMH+AjL6IX6ulij9epxrPxfDrbazDgIi+Kn9iLU5tMEOREVtCvJqpGY5QLyLGnNi2RvyV3lHPCSPybz2CGIn5xZjrI5Fo/ipDNUvHxjNp6WaCf7M1+L61Nxx3KoY2fXQoOzCCiMtaYsmutQ7pZir+G1I/Iuq3QCcUxa0pZSjCgc1dSppGFfzXBu74jd+22dmjiBv7uecH2NgYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775217397; c=relaxed/relaxed;
	bh=9l7YRnXiJeaUSputbifksPPi0XaXtllvN3GOhiFO6oo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SCMwaOYtaO6tJs82IW/Vy/bn32MVnmpYB32ZcuvwNa97YRSvPviiDB0MyOCs743nk/yFukmvof4vbNgfESpT+2mPd2hg+BZQPaBHTvkFhiy9RyQzu3Sv0W+Ao9z9BoWnKkfO0y2Yu/J7uqMUO6WhkDwkUfi2YpWNU3NluKMNWBtYhMzu1SsU1iS1hx6quLKESZKjsjR52pS1+hHl7QBWfwP4R/svDVZ5szIkr/cfQhRi8FN8Y7sekHVWwl+2if6i2203zMIIDkClZh5biXWZtoWCY/rsHDH8fLdmTTLXzZd/K0tRA5Ab1MK7AjCL4B3Jmh5H7Tw7Bf34Bvz7WXX7WA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=eLufVd3z; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=eLufVd3z;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fnHJ454YSz2yVP
	for <linux-aspeed@lists.ozlabs.org>; Fri, 03 Apr 2026 22:56:36 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 2AAF760008;
	Fri,  3 Apr 2026 11:56:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E3A6C4CEF7;
	Fri,  3 Apr 2026 11:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775217393;
	bh=9l7YRnXiJeaUSputbifksPPi0XaXtllvN3GOhiFO6oo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eLufVd3zXy9jubkTC9dwkw2QYzwtvaWjru+m4ZdRkawSNi9+nrDNC6gUO4mGVS6/R
	 gkBybMRFcG6wp9frSh1UrnRTFmFAIWeWQ6JjhxrMtKfvi/L8jlqp4jSjvl7EXEDDzs
	 ZtNPjIHE0ChL+R5ThH0m0bg+INk64ahwnxdcJwFR/q6vQTBSBkwaCRWtjZT24m2vTQ
	 7MxtkfclOy/wmKMdP417H2f+HSQV3sLIh5VH4IlCqqK1iv9HKmpZHIBbN8ejL1uHof
	 f/augOwXmiWn/yGSuidAzKcnlp7ywm1cPXBOrcNHhnI6tgb8ARqohzJKj7eqgaBFB+
	 mw/4aiwR3j/hQ==
Date: Fri, 3 Apr 2026 12:56:24 +0100
From: Mark Brown <broonie@kernel.org>
To: Douglas Anderson <dianders@chromium.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Robin Murphy <robin.murphy@arm.com>,
	Leon Romanovsky <leon@kernel.org>,
	Paul Burton <paul.burton@mips.com>,
	Saravana Kannan <saravanak@kernel.org>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Eric Dumazet <edumazet@google.com>, Toshi Kani <toshi.kani@hp.com>,
	Christoph Hellwig <hch@lst.de>,
	Alexey Kardashevskiy <aik@ozlabs.ru>,
	Johan Hovold <johan@kernel.org>, alexander.stein@ew.tq-group.com,
	andrew@codeconstruct.com.au, andrew@lunn.ch,
	andriy.shevchenko@linux.intel.com, astewart@tektelic.com,
	bhelgaas@google.com, brgl@kernel.org, davem@davemloft.net,
	devicetree@vger.kernel.org, driver-core@lists.linux.dev,
	hkallweit1@gmail.com, jirislaby@kernel.org, joel@jms.id.au,
	kees@kernel.org, kuba@kernel.org, lgirdwood@gmail.com,
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-serial@vger.kernel.org, linux-usb@vger.kernel.org,
	linux@armlinux.org.uk, mani@kernel.org, netdev@vger.kernel.org,
	pabeni@redhat.com, robh@kernel.org
Subject: Re: [PATCH v3 8/9] driver core: Replace dev->of_node_reused with
 DEV_FLAG_OF_NODE_REUSED
Message-ID: <fdbe1d8b-d323-414d-a705-cf2dbafe2fcc@sirena.org.uk>
References: <20260403005005.30424-1-dianders@chromium.org>
 <20260402174925.v3.8.I806b8636cd3724f6cd1f5e199318ab8694472d90@changeid>
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
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7NZIk4CoO0re4Kx0"
Content-Disposition: inline
In-Reply-To: <20260402174925.v3.8.I806b8636cd3724f6cd1f5e199318ab8694472d90@changeid>
X-Cookie: The Korean War must have been fun.


--7NZIk4CoO0re4Kx0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 02, 2026 at 05:49:54PM -0700, Douglas Anderson wrote:
> In C, bitfields are not necessarily safe to modify from multiple
> threads without locking. Switch "of_node_reused" over to the "flags"
> field so modifications are safe.

Acked-by: Mark Brown <broonie@kernel.org>

--7NZIk4CoO0re4Kx0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmnPqucACgkQJNaLcl1U
h9BRKQf+LiK4wJzBJvOcF8tPspBBv5slh1Rv07RAYfhsMajrfvb91fBup9erBnC7
uop2lhbeef3E4GYUNM3af2BFUVTr6Q2yQsCgV5p3nED9j4EZmCsCSp3X0Hbcc+S1
RmxEf3FESw5jl5dAifyRzEtHhqMmQoiJiWHstiX08tmRvb230IM4SoMj9/XTx/hJ
qZLOPBhvbwfqLgqtzR6YbvKHy+eG/muzoWEC6sNgi5JBsNQEeCY0Dp4nSfxbN1i6
VGMAgiL64FDOsOQ3BG7hFoQ0OFAsOB2CiaPDKh4qopTzS+avykiGQvxzCn4XfBfo
8ZM+Nrnu/VYKm5P6K3uIcHF11UpYhg==
=Rocu
-----END PGP SIGNATURE-----

--7NZIk4CoO0re4Kx0--

