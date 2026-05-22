Return-Path: <linux-aspeed+bounces-4123-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E37ADCD5BBF
	for <linux-aspeed@archiver.kernel.org>; Sat, 23 May 2026 01:50:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gMlT61bT5z2yH5;
	Sat, 23 May 2026 11:50:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::435"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779437963;
	cv=none; b=V3cCWGWaMp8Woc+KQalszV43e4VimlC4c5wolS2yftAufL4VGtXStNP9PdLa/IHjAvLt+nM8iEGAwbaFmKFOZ0XP65PQG55r4yWHEtL7CMGI+/qBHi9+Ago5ZniXOUMaD/AEGFXa2pi3VlYFuk13DveR/LrMs/63z7wspp/PNVHqbYfNGa2MDk6BtHaInIYVIBgtoiVdmswnrfZM6h7n+FU1m7fBDe7IbJ9Sm0xGqUh56NuH7YZME7pdSokdJXhjjITRrE9fojjSn3n+hI6gLVpqTSREA+Bqfjw9UphLxwaAulI8W8gJIDpRAHL3o4FFGnBu/E116LaFZctKAiv+zg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779437963; c=relaxed/relaxed;
	bh=USopUhbYAD9H+P5jY922wxECkr8a746/WdiaOhzpN58=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SMl14QgER7JGSFRGOxLuOWWXgPRpVMrTQiggzqS6b+ioKPdr+lp3ImO2ftgWZu9V2HxAd1J8BGUfVcoCpD8qERQT+dHXIyNSezNe7cg1lIaFv4VWET6KiHMpgzJII9TG3Ov05s9OKa74cKinN3Z0zHxOmaF9OyAwWi/RuamrJwr6GEXRjXhsePiuxkaMhC/WyhY27UjZzLUz/sBRtnuoJn6VyRdrXD4LAf/F+PTjLb81LeQ2cw6l2yfPdNDeAdCeiEJvwNZDslnqMhRV4/l/zop474q4WGCC6BEgh5pXLPk49uEqbGMxDHy00Zz8d2Ljb/q3TZXvTnIipx+Nfal7pg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Fa36qcfX; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::435; helo=mail-wr1-x435.google.com; envelope-from=david.laight.linux@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Fa36qcfX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::435; helo=mail-wr1-x435.google.com; envelope-from=david.laight.linux@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gMJ8p0glKz2xSN
	for <linux-aspeed@lists.ozlabs.org>; Fri, 22 May 2026 18:19:21 +1000 (AEST)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-44a74032ff8so5209036f8f.1
        for <linux-aspeed@lists.ozlabs.org>; Fri, 22 May 2026 01:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779437958; x=1780042758; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=USopUhbYAD9H+P5jY922wxECkr8a746/WdiaOhzpN58=;
        b=Fa36qcfX6e11MWXCpeQPsBgshAT+HNS1bp5au5h3cA6UhzRoHPPPrEtgcdwLys9OJd
         o9ECUjsvO77skyRfkBIwrbnn5hE140wuD+bcEHL/nok0qxLHN/+rh4zXHDyicR34tPZj
         MeKhXjq//2xw+54kmghMF0UvhypOptTU13DM0YAVvuEcV5NA1dSlyLiJz/5uuT4qhgxx
         hyCbMBDNj+vqenyG0dOlwesA92FQuPxgE1z++UDhzxOipRjv/xZeLccBj4ftGk2xmT/W
         9v4u5fajPD/Z5wQ5iJp0RXgsb6h1EOqnQ/8X1TzaP4mT2UqSJmS/rOhTlStG2gjHzEwx
         NI7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779437958; x=1780042758;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=USopUhbYAD9H+P5jY922wxECkr8a746/WdiaOhzpN58=;
        b=Qq9PWcsFX6UvlZz0oqfoD8wuYs1Lh1KvH84WG2hBccUhu7+hgpXHf8i8TKNL2PUwe4
         dKzyZ1cKKW7UoRT/RwoptR72sQE0Or5Wko4/tHRVzKe7b6gS0jMPoEWDQ0oTrsS0Rn8T
         GbKjKtmyeF6pUVGzMSLBCoNabwg370pe1KZzB84kvy4nVuFtwnfeRzhdTybhh85ng5ID
         ojIotsgBepju3d/f87aJzdX/QhXLnM0mDQgcTPA8KCMclYb+hkrry2/whLfylo6FP2co
         3Z+gHMM/sUlVt5DEkd5LHcCn67JJJkY3P1qE+qkGed8XtcLu0uF4+LGdjtMdql60IrPG
         KWEw==
X-Forwarded-Encrypted: i=1; AFNElJ/qadmsX1M5TzoyujuXpS5OKXw48pWS0DZqjGrxG7lKAOQKbPz6rgbSiqqbUibQMD8xRPb+OWm3yfcv6lg=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxmuH9feo+FYBMRJz2vv/F2OLrMjDwEajaPL2mGGvsQoJRkg9GB
	aaY5KI5XYzRpRx8iPVXwb1AGvWbqYaT8/V8XSi+ORKRb+jFNhfH6pAvX
X-Gm-Gg: Acq92OEa9njF8v12zLxvVdme/ehVVQ5kSq5HTkrJ/jGVJGD3YvIW3isA6X0XtrkAHri
	S28NNwQc2L5mTpUhtzD0vZii3U2E8/0e0temb+39tdGhzZA937geG3Qh0xanB/X0jq/HgsoWMLk
	1nuIZEWYjZGs7FKopufbShC3LfWbrZkyg3sDq6V4B4BrjpJDyFjTfyfCApkxl8SeIuyc+LJKnCX
	Qi7YH0wODx6tugdL2MyoyI+NPZ042kkJh49gK6Iy6IvlDUPyvZsHChIw2XULEt1cKTdJgn7jGH7
	p+Jj7KGBI8l2rYryxQ6mj+iPVJxTg8VWoP/iP44MKf10ldRMVOVLMOd7n3UO9Mz9PRzZIGH4uvJ
	xhLH0epN2O0ie2PvOxHPvgRHlzrNTPKUKwTW/9szWuyokwdIuGrduynV5WMsap7+kPCIWXgiM6B
	lpiCdA+vVyVadsb7e9M1tw9ly3Yracz33GbK/Qgyd73WpYO+4gsLHcpX2/PeLsyfBz
X-Received: by 2002:a05:6000:1848:b0:45e:73eb:2a75 with SMTP id ffacd0b85a97d-45eb367fb1amr3404088f8f.16.1779437957497;
        Fri, 22 May 2026 01:19:17 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eb6ccd04dsm2451454f8f.9.2026.05.22.01.19.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 01:19:17 -0700 (PDT)
Date: Fri, 22 May 2026 09:19:15 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
Cc: <clg@kaod.org>, <broonie@kernel.org>, <joel@jms.id.au>,
 <andrew@codeconstruct.com.au>, <linux-aspeed@lists.ozlabs.org>,
 <openbmc@lists.ozlabs.org>, <linux-spi@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 <BMC-SW@aspeedtech.com>, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2 2/2] spi: aspeed: Replace VLA parameter with flat
 pointer in calibration helper
Message-ID: <20260522091915.65dde4ad@pumpkin>
In-Reply-To: <20260522071621.102507-3-chin-ting_kuo@aspeedtech.com>
References: <20260522071621.102507-1-chin-ting_kuo@aspeedtech.com>
	<20260522071621.102507-3-chin-ting_kuo@aspeedtech.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 22 May 2026 15:16:21 +0800
Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com> wrote:

> aspeed_spi_ast2600_optimized_timing() declared its buffer argument as a
> variable-length array parameter (u8 buf[rows][cols]), which causes a
> sparse warning. Replace the VLA parameter with a plain u8 * and compute
> the 2-D index manually. The corresponding call site is also updated.

This code is all a bit horrid.
The 6 and 17 (which are also used in the array declaration) have to match t=
he
TIMING_DELAY_HCYCLE_MAX and TIMING_DELAY_INPUT_MAX values used for the loop=
s.

In any case the code would be more obvious if the 'run length' of test
passes was counted during the initial loop.
Looks like it wants at least 4 ones, after you've got that many
(and a fail) there is little point continuing the delay loop for
that hcycle.

-- David


>=20
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202605180441.uD3toFRJ-lkp@i=
ntel.com/
> Signed-off-by: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
> Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---
>  drivers/spi/spi-aspeed-smc.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/spi/spi-aspeed-smc.c b/drivers/spi/spi-aspeed-smc.c
> index 808659a1f460..027caa2eeb5c 100644
> --- a/drivers/spi/spi-aspeed-smc.c
> +++ b/drivers/spi/spi-aspeed-smc.c
> @@ -1467,8 +1467,7 @@ static int aspeed_spi_do_calibration(struct aspeed_=
spi_chip *chip)
>   * must contains the highest number of consecutive "pass"
>   * results and not span across multiple rows.
>   */
> -static u32 aspeed_spi_ast2600_optimized_timing(u32 rows, u32 cols,
> -					       u8 buf[rows][cols])
> +static u32 aspeed_spi_ast2600_optimized_timing(u32 rows, u32 cols, u8 *b=
uf)
>  {
>  	int r =3D 0, c =3D 0;
>  	int max =3D 0;
> @@ -1478,7 +1477,7 @@ static u32 aspeed_spi_ast2600_optimized_timing(u32 =
rows, u32 cols,
>  		for (j =3D 0; j < cols;) {
>  			int k =3D j;
> =20
> -			while (k < cols && buf[i][k])
> +			while (k < cols && buf[(i * cols) + k])
>  				k++;
> =20
>  			if (k - j > max) {
> @@ -1541,7 +1540,7 @@ static int aspeed_spi_ast2600_calibrate(struct aspe=
ed_spi_chip *chip, u32 hdiv,
>  		}
>  	}
> =20
> -	calib_point =3D aspeed_spi_ast2600_optimized_timing(6, 17, calib_res);
> +	calib_point =3D aspeed_spi_ast2600_optimized_timing(6, 17, &calib_res[0=
][0]);
>  	/* No good setting for this frequency */
>  	if (calib_point =3D=3D 0)
>  		return -1;


