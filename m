Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A70606A982
	for <linux-aspeed@archiver.kernel.org>; Wed, 18 Nov 2026 22:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=gm0quFBn
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jVGfl1Pgfz2yR1;
	Thu, 19 Nov 2026 09:36:31 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::32b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795010810;
	cv=none; b=MHaiQhVOp2Dm0r5R+ssTw9UnUqe5uZmxonhR9kYChjfutAVO2D9EQ4JCb9p/Co2FJdFU0UKLDWYRFW7XFCPZt5wBTHMyi00byrVt8IVa5qwGJWod7/d2ol2SS0viOgt9Sei8lQaX97Prxq7Iolu0P1LvqYFUWeyIynSsMp7G3I4gu5jjl3l4cVCNvmOgt9Dz/UkeR6xxbKhyari3wm+otSKQo/TYnPiBHYVp5uBcBI0EJJi8H+i3EFUnaYICKwRCUJOpp2VMp/0dkGH4Bkbs9GLJNS7t+vFrL0kcGvBLvLz7oWpajaajwg7t4ov8YhfdJVkVurRdR59fxX9tvWKNwA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795010810; c=relaxed/relaxed;
	bh=O8kUxWwNMGGKdJF+2JBGIvhWCx8VFS9Gq0fs2XPEP3c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W5FIY9fUtr8knDfbiJJMshEvCZ5pIK9x1bkigLX3Ayw0jkStxqfdQV1H4Du6EnPzGVWGUtxXQs/PqDAy0i+tu6PLrvBujATQx0s254q0Pl19Lb5xOYeNwpO7NlGSjkI9KCXmfW9FL4c1xEo1fZqmuKouk5U94Zl09PN5RC0f4ZETmPGJLS8BYmtup41lUALw2Qaud7J/Tb65VHfEUXktraeo6gFABupNbs7BlAcTjLEZvioM3u/vngeEmIBiDCv9SaXicQc8YXPReBLbYMljJQ1KrgoAjglIuKLIFJCgowE6WjxAJ1QNq7vYJIX1m2wJy7CENfxYXEEG53o8tB/s+A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=baylibre.com; dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=gm0quFBn; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::32b; helo=mail-wm1-x32b.google.com; envelope-from=ukleinek@baylibre.com; receiver=lists.ozlabs.org) smtp.mailfrom=baylibre.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=gm0quFBn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=baylibre.com (client-ip=2a00:1450:4864:20::32b; helo=mail-wm1-x32b.google.com; envelope-from=ukleinek@baylibre.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jV3Ld1GNpz2xL4
	for <linux-aspeed@lists.ozlabs.org>; Thu, 19 Nov 2026 01:06:47 +1100 (AEDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-4bb6886d30aso9014655e9.3
        for <linux-aspeed@lists.ozlabs.org>; Wed, 18 Nov 2026 06:06:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1795010804; x=1795615604; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=O8kUxWwNMGGKdJF+2JBGIvhWCx8VFS9Gq0fs2XPEP3c=;
        b=gm0quFBnz17GMvZK49R6P9s5enhlFcVY6avh/YJBcqJVi3jGP8mMSbqyIy26shnhDa
         LLXKH810A23SSkJyx9b8cPUmKAkANtj6eHh6O8Lf77xUDiNFDU5m+HvWwhqQMH2bboJv
         v5ef6rcoGbL0KkBtbw2pL6U9/FUgmo8MX5h8vxhTjYhYgLk7Lmt8kYOCEOmr/Irp6gny
         g+b81rm1ZYlntPzlHQlXhqdLOOndtlHubH6dTLGMDIr4wWa92tlefjZLoTtAK/5s03m+
         hTa1elFN9JxEsdmupBUqJlwGmRZNr2rj9G3gZsx5IlRQTpWuUgABysDdYSxMVIO+DJok
         qnMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795010804; x=1795615604;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=O8kUxWwNMGGKdJF+2JBGIvhWCx8VFS9Gq0fs2XPEP3c=;
        b=TV7A12x5nxMmAb25wBfRuZk5QlCRnpTWuwohiPh33GOy9onNVHQaXzceYFdMkkNYls
         6YCSdu/LnajK3GMMYvo9BIvP5peT9GZDTvxZktu5t123YXdsvQz/EplEEtDHHzWUaL7D
         XiompvhRvK8iO3yrl+lM/CcLOLbjpaKdkSS/CI4PVe2wEXd5clUUGGxEPDXUC5FXFyaC
         IeUtxHnaOgD8BCv87FxDHGjRUtkesZZMhLiJqLiRWAjL15GmnEiJntzqULCX6xMJIECJ
         R4r/hecallRnOr0sveEpDq6D/u4pm1fKsvWO1isM1m16SyAl2pecJOqnN6OX961vcMZJ
         tm6A==
X-Forwarded-Encrypted: i=1; AL+hErHXp528g0u4TipAV8V0s9qx0Utj51jLtfSmkQRCiNsYjAZNdlmPD1jO38g8TNZCgCzAckoSYNr4Etp0djA=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z8htv2U5Fhk8+EEOTbgpHKENi5L4Iur6pyv/euEMcywKl+YU0Tu
	7V9ACN8A9OgeBVMlug1wCQZqyaJanj3nj9OxPABz/LTTudWXlxJQUwhFgJDZafpD4dI=
X-Gm-Gg: AYBFou1MdNOIgPfFPl2+jxxX4rUhj9L0pDpVsLXTPINEL1oc27BKsNYltFacdugqVR6
	KBLUJhHJt06TQ2b8NgfqGEVnmn0vaISQVOuHsJNVQzw4snttnRC79CZJpBNT5cLCaw6ddjEvrhU
	wQ9Dr1hKd5LDGwwftNB0k6R85fGkeeg65+omJ/yy71jHjDBR4rg7tuJGRnMTh+jart3m2kh2hIW
	wrOH5lNtHeC/D0XZvhu00ipSYvZTD2lcCGQuHeSGbjSz5JHqRy1IXVu1B4CzlhbVBdgVhZbqY0Q
	98Hy6otUAI5TQLIHUFj3qcjHnbrtxDh36L5dguE5KnAdzz5J5Fr0CVjclV4EL9s9QAJKLrGtK1o
	II6LqyE6O33pvH7NIVSk+r8CStol8zBTT3h2PCUefLTS/jLRE9HUaSQhB/E8Ez0x5WUHjV+99Hj
	WNN1XiC74axKCGnT0onXAibdFqO2v8EcqkEdyLGZESEd++cWJRKKTbpF2s+wFIqU4Gb8/MQ6gSz
	9rGy7aTO5iucXDy0fRj+SHdZtPRUTtlBIy5pajpAUveNm/KMI/ig+fKmYrvhAbmu6BFWOMdMpLy
	Rn+eXWL8+/Upx7rNdl/HhVzjk37vfRMoERk=
X-Received: by 2002:a05:600c:3509:b0:4bb:68b9:f610 with SMTP id 5b1f17b1804b1-4bb7da03954mr52120315e9.9.1795010803953;
        Wed, 18 Nov 2026 06:06:43 -0800 (PST)
Received: from localhost ([2a02:8071:56d1:2de0:1d24:d58d:2b65:c291])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4bb7d256f64sm61534715e9.1.2026.11.18.06.06.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 06:06:43 -0800 (PST)
Date: Wed, 18 Nov 2026 15:06:41 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Sasha Finkelstein <k@chaosmail.tech>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, dri-devel@lists.freedesktop.org, asahi@lists.linux.dev, 
	linux-aspeed@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, 
	linux-riscv@lists.infradead.org, etnaviv@lists.freedesktop.org, linux-samsung-soc@vger.kernel.org, 
	intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org, 
	imagination@lists.freedesktop.org, linux-mips@vger.kernel.org, lima@lists.freedesktop.org, 
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org, 
	linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
	virtualization@lists.linux.dev, spice-devel@lists.freedesktop.org, 
	linux-renesas-soc@vger.kernel.org, linux-rockchip@lists.infradead.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-sunxi@lists.linux.dev, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v1 9/9] drm: Unify coding style for *_device_id arrays
Message-ID: <av2rKJQ0AKU9CFZI@monoceros>
References: <cover.1795002467.git.ukleinek@kernel.org>
 <a2d5ce256b8ec150de4a6494c177b19693a33222.1795002467.git.ukleinek@kernel.org>
 <7692c160e418e7ad0528739fcc879b11fbac8ab0@intel.com>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5c6ped4sw6nigwko"
Content-Disposition: inline
In-Reply-To: <7692c160e418e7ad0528739fcc879b11fbac8ab0@intel.com>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--5c6ped4sw6nigwko
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1 9/9] drm: Unify coding style for *_device_id arrays
MIME-Version: 1.0

Hello Jani,

On Wed, Nov 18, 2026 at 03:27:40PM +0200, Jani Nikula wrote:
> > [...]
> >  drivers/gpu/ipu-v3/ipu-common.c               |   8 +-
> >  drivers/gpu/ipu-v3/ipu-pre.c                  |   4 +-
> >  drivers/gpu/ipu-v3/ipu-prg.c                  |   4 +-
> >  254 files changed, 1155 insertions(+), 940 deletions(-)
>=20
> How do you expect a patch of this size be merged?

Using b4 am :-) Honestly, in the cover letter I wrote about an immutable
branch and offered to rebase to 7.4-rc1. When trying to apply this
series on top ov 7.4-rc1 there are only 6 conflicts (1x modify/delete
and 5x content); these are all not so hard to resolve (and even dropping
the respective hunks (i.e. resolving using `git checkout HEAD`) is fine
for me.)

> > diff --git a/drivers/gpu/drm/i915/i915_pci.c b/drivers/gpu/drm/i915/i91=
5_pci.c
> > index 84a7dc6ab5db..faceb3de4fa3 100644
> > --- a/drivers/gpu/drm/i915/i915_pci.c
> > +++ b/drivers/gpu/drm/i915/i915_pci.c
> > @@ -870,7 +870,7 @@ static const struct pci_device_id pciidlist[] =3D {
> >  	INTEL_ATS_M_IDS(INTEL_VGA_DEVICE, &ats_m_info),
> >  	INTEL_ARL_IDS(INTEL_VGA_DEVICE, &mtl_info),
> >  	INTEL_MTL_IDS(INTEL_VGA_DEVICE, &mtl_info),
> > -	{}
> > +	{ }
>=20
> Personally, I would *always* use {} instead of { }, and would rather not
> change.
>=20
> Across the tree, {} is slightly more common than { }. IMO changing them
> is pointless churn.

It depends on how you count. My statistic looks as follows (on top of
next-20261117):

	$ git grep -l device_id | xargs -n 1 perl -g -n -e 'print "$1\n" if m/devi=
ce_id\s*[a-zA-Z_0-9]*\[\]\s*=3D\s*{(?:\s*{[^}]*},\s*({\s*}))/' | sort | uni=
q -c
	      2 	}
	      2 {
	      6 {  }
	   2598 { }
	   1262 {}

So over all *_device_id { } is more common by a factor of > 2. This
series fixes one {  } and reduces the number of {} by 37. For only
pci_device_id it's:

	$ git grep -l pci_device_id | xargs -n 1 perl -g -n -e 'print "$1\n" if m/=
pci_device_id\s*[a-zA-Z_0-9]*\[\]\s*=3D\s*{(?:\s*{[^}]*},\s*({\s*}))/' | so=
rt | uniq -c
	    159 { }
	     32 {}

Without the context of an array initializer there are many empty
code blocks (function bodys or `do {} while (0)`), empty dt nodes, and
{} in Rust code, which IMHO have to be considered off-topic for this
statistic.

Best regards
Uwe

--5c6ped4sw6nigwko
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmr9sOcACgkQj4D7WH0S
/k4vggf+PQfM4MkbLgaQRCdXRWWsc4/Fa0tTMBQAl4gjx2p5NE/N7TDUO571o3+N
oWcelzY5O1uRcc2qHZVnu3vAxFqzk4YHfGjsbGHsxQAibxnIFW7ttYTzt0w5a9NH
v65V6+sebCdwLrPVE5ilcqzFFSgmnv1wTNm2vCEUxdKGacifySaGRmg4+ax+fLb1
CL+RS7fM2EkQxG1k4iDEPv1Onrm9S4DtwTts0wxkK780rWYD9FoSLjHyX/x21Y8x
SZKaXeNZlxtHJpQLq8ub8AL/t6k82nC020wYZOUbUmvPyqxhNoUuuS0/RVlz9xT6
kXiliIwWzcMtAKt4ik8nbTRO5JERhQ==
=0alU
-----END PGP SIGNATURE-----

--5c6ped4sw6nigwko--

