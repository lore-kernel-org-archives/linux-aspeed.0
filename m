Return-Path: <linux-aspeed+bounces-5011-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 319F7C88E5C
	for <linux-aspeed@archiver.kernel.org>; Wed, 16 Sep 2026 07:47:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hl9vY2X5Hz2yGT;
	Wed, 16 Sep 2026 17:47:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789544825;
	cv=none; b=SGSucYDydE0yjijOBPtkwEw5RxSkoUGyI6cdr/E3MvwfxuzpwFbjoh2TodFYbCBDr2tuoFnZIR24HXPvRBkGuvWCm/tIGh7Sil1MrXzxmUVgwIAKUJ223yIoeuWW8Q35iZAFIMfwru5ECQosiWUgCJzTtwIh4rccnon3NPifBQDx4EFm79kICIKOEtxT6ASTNuN/GZWF9HCey3Bx0ORJi5UK6Q3vtb7xMQywI96RJhL1foPR4CZpMLeCorQn0AoO7KElxyZrSbQHN9gz+tSf2b9SB/QLiUWURaIWmQJ1URAbdcd0kVOXJbZQ85N1yTeKhZ4JLEyF8BLKfwB+QnBmwA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789544825; c=relaxed/relaxed;
	bh=0joaZXkFzvHsMPXxvnQrk/bZSSnjHuyjzDW4e7lSU7g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X3QVkoNcoqr82WbV/t3hM5cmSo4b59v48AYgdgdXwwNl8tEedibk1/ko9gXgeN1zVh9f+LWTkepCL8jKCNWbwXbeN4wTruBRiEMroj4QjAIQywfmwzWQ1qJ1MdCPOWhaxLK+dTBZ+uSnABHd25Kdd9mfkDACtvu8mqaM563sTKOUrFROyMNk1r3hG9cxY3/p0Klv3dRGWzPa1VpTjRv7BVuNsFI8aG3kOhW/G2SNx/rCG4BtND3m1a0OPHuSMEljD9NIzQjRzFCctevRfrDQC/6bvHu6EZ71Ehc78+FEciplvWBtAOf2UNyNIXDlZ7kaqIR6T/AoYKnJCcCvi59ILw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Nc+M2tZw; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=mripard@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Nc+M2tZw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=mripard@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hl9vX4F16z2xlY
	for <linux-aspeed@lists.ozlabs.org>; Wed, 16 Sep 2026 17:47:04 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 685B66020C;
	Wed, 16 Sep 2026 07:47:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BAF61F000FF;
	Wed, 16 Sep 2026 07:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789544821;
	bh=0joaZXkFzvHsMPXxvnQrk/bZSSnjHuyjzDW4e7lSU7g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Nc+M2tZwVJsixOM56NLEFYEzQkaMNDIiByci6H3lph5WSy/sEnP/SvbP6NTlniikG
	 Ewmocn8mbkhzZl9xv2kVMDBr9tzV6fTxVdxlVlUs7jGzcaKO2mFJVVhpduKi44oong
	 sHtZYmooyLnIcMDIU55vEXNcmGKmkaxT2821zwOmgb3Efs5H3NrjmHxgoHWATRdia5
	 KNsXvB16dSqeGTjIGJunLyXRJRAL3W18yGfPBId94h5QLA//ndBGRfh3HO0XR5ZLsF
	 ZZfrrn52BOrmvfzleaLFXxmfmxJIZnjEVpiunf5J+VIySiejvQLBNbUK5GOMjqX3Eh
	 +6UMsYsqAvK1w==
Date: Wed, 16 Sep 2026 09:46:56 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Ze Huang <ze.huang@oss.qualcomm.com>, 
	Alexey Brodkin <abrodkin@synopsys.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Joel Stanley <joel@jms.id.au>, 
	Andrew Jeffery <andrew@codeconstruct.com.au>, Frank Li <Frank.Li@nxp.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Linus Walleij <linusw@kernel.org>, 
	Hans de Goede <hansg@kernel.org>, Alex Lanzano <lanzano.alex@gmail.com>, 
	Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Marian Cichy <m.cichy@pengutronix.de>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, linux-aspeed@lists.ozlabs.org, 
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, xen-devel@lists.xenproject.org
Subject: Re: [PATCH v3 2/2] drm/imx: replace struct drm_simple_display_pipe
 with regular atomic helpers
Message-ID: <aqpJKSSKunElnQ3o@houat>
References: <20260727-drm-simple-kms-removal-v3-0-de36e534f7a1@oss.qualcomm.com>
 <20260727-drm-simple-kms-removal-v3-2-de36e534f7a1@oss.qualcomm.com>
 <8e4c84be-5c89-4d84-adda-aad4c7de0c8a@suse.de>
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
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="3s4tplx46ij6zcs2"
Content-Disposition: inline
In-Reply-To: <8e4c84be-5c89-4d84-adda-aad4c7de0c8a@suse.de>


--3s4tplx46ij6zcs2
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v3 2/2] drm/imx: replace struct drm_simple_display_pipe
 with regular atomic helpers
MIME-Version: 1.0

On Wed, Sep 16, 2026 at 08:50:21AM +0200, Thomas Zimmermann wrote:
> > +static const struct drm_plane_funcs imx_lcdc_plane_funcs = {
> > +	.update_plane		= drm_atomic_helper_update_plane,
> > +	.disable_plane		= drm_atomic_helper_disable_plane,
> > +	.destroy		= drm_plane_cleanup,
> > +	.reset			= drm_atomic_helper_plane_reset,

Also, this needs to be drm_atomic_helper_plane_create_state

> > +static const struct drm_crtc_funcs imx_lcdc_crtc_funcs = {
> > +	.reset			= drm_atomic_helper_crtc_reset,

 and drm_atomic_helper_crtc_create_state

Maxime

--3s4tplx46ij6zcs2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaqpJcAAKCRAnX84Zoj2+
doCwAXoC9/rqP3SJq9eA3TmbsgUL1dNQBlXU005d6LFRuERn952eYKYsEdnw0oH7
sS3Ms8EBfiZnSTC8Whf1zsDguMj/m/bcSyfEzHV6wM8Ix8qPXjNRdKfvP1twZo2V
tHED8pYuFg==
=LKtN
-----END PGP SIGNATURE-----

--3s4tplx46ij6zcs2--

