Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD77606A321
	for <linux-aspeed@archiver.kernel.org>; Mon, 23 Nov 2026 09:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=B8jB9zTS
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jY0f34RnXz2xyj;
	Mon, 23 Nov 2026 20:15:23 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::336"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795425323;
	cv=none; b=cXDxmiJzq52PXYmK4C/7gskeDznekIHuA29lWMNEPgufVY0g1lbOMJmIa8PK9duh3TMOIedXNbXw/vjIUvbxAn8+xC39PydLAGzRUstMDQyjs+laEaV1UlNF1367iIMhVAkKUN1LPYViigAEEQoKXEdE1gx9bNSLJm7YEZijJIMDF9o3SQpvzf5uWscTl/dv39HClzeMZ4HqFaNbPiqT55KYScT1VBPF2QwihWtgZRC/8A0B/fhLOG6qjwJeHVIhvIorocoVxzBWagR/KTxQzHwgIscVX7k3gDZvJ501Lb+tUi8p+hR1DzrZciqUdfg42E0kKQX/KX4vYnfeUp5WiA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795425323; c=relaxed/relaxed;
	bh=87mz9PA+CW/7E4uRqcEgoSgLyusH584rSyT2Z/HLo8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LOh4Y0eo0xytEByXVBCUhrMw2Os334daHwmFpH539VANwozeEz1ZDoQ3iS8sq2Zql/1AwjqRUOCUvYHf0tGBcpaeOdpBe6FJYALzpLuuLeiOv0NaY+jZC0lw69eOE3YgsCAc2XwyLdoYJFI5cMQ/jl1eYfJRUK+9NFZDTwzznmRXEtByB6YRIpZjt7keCe2C88EezO2Ne9XtL68CdR28zD9BLXMMsH7b1w8+GsAcXjFMSfRBED6siJqQ0vAqvXnObmcvESaLeN10OhKc3oALzob5unKcbHQN7R+JMsBLBGKBcDD69CyGuYHMFYFMQ7ODAEKhpuY1nFD0rWl/WwhDkQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=baylibre.com; dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=B8jB9zTS; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::336; helo=mail-wm1-x336.google.com; envelope-from=ukleinek@baylibre.com; receiver=lists.ozlabs.org) smtp.mailfrom=baylibre.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=B8jB9zTS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=baylibre.com (client-ip=2a00:1450:4864:20::336; helo=mail-wm1-x336.google.com; envelope-from=ukleinek@baylibre.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jY0dz6dTJz2xBb
	for <linux-aspeed@lists.ozlabs.org>; Mon, 23 Nov 2026 20:15:18 +1100 (AEDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-4b467581b98so27682065e9.0
        for <linux-aspeed@lists.ozlabs.org>; Mon, 23 Nov 2026 01:15:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1795425314; x=1796030114; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=87mz9PA+CW/7E4uRqcEgoSgLyusH584rSyT2Z/HLo8k=;
        b=B8jB9zTSwfhmVDQBM5QsBhI4RMegTq+iJqmMzJtXuvygokFEGAjL1kmWUEKTGFBbDm
         zocEBfX8es8gmOqhwecJIkMfYxrT8i2c0zX2skTZNEjfvk/kYmU8U1qiupMOiQh9FFs8
         M9u4JRB3ihhrRVNPy+pdHdKfjHouzWe1bKwXt6EVFT33qjoJqspFy73QfsEqgU7BhuLe
         /RWGmCJKcJCASRRxTeZN6A2N43DurpO31TtbPSCTUXxA8bxhGkuCqbztka6gfYdleA2+
         peL/4UzpdjFGMQ8Mmn0uI+wzNlgA7SN/zxBckd+jwTZK3DWjmZoN/JD6BNXpKM2z/J5H
         ll8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795425314; x=1796030114;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=87mz9PA+CW/7E4uRqcEgoSgLyusH584rSyT2Z/HLo8k=;
        b=YjeZK/avlebpE1VbBwK6RbLYm/GyeKKYZvbhjzglAF9ftZjAI5t1MlFXe4BxoU3e34
         HmAKO9zYi+vlaGJyCZUEZCoR1NO4w9wmjrDLt/KQYpACcij6kdk48kYQPntkF9hT9BTX
         tcVUM10GJX4xeDFcDQ+gmgCS8tppW3A6Alt8VrXlu0muT+Ueuo50GcWVewhTn30CE7hB
         gOrGu0jwdfMQalosITAOr1ll5YaBcmfsCxJOdGb8beVnIL7NY6uvWT3CzP7lYBYZFAXL
         0ZbnYL2e93101Q1zlsUfM+y/71jLBi+HfNOVQF4niTKLOAn7Y6bCzxNG3PNtQEyD2T3O
         DdKA==
X-Forwarded-Encrypted: i=1; AL+hErHswGJnK7+kUJspIFXK/sLGPf2CTz2nTZI/kSt+pDaFGgiP5pccw8oQ4DpNITQ9aMW7xQSsvbk7o6RQ1qg=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z804lH96kgAqYRKdiTyq5wPZ9myL/iFVCFS5NoUN4BdXr5PVJvk
	KDWdgF++FtGb1VhMw5zWMGcMBEfAvwImgw9GX7pcKyl9jvq1CDuWHl3HOfW9UhgxuLg=
X-Gm-Gg: AZFdTZfwrg2sbUzbYCDsduZeS94i/OZ8G44buPtM2/1c2bdJTOdwY7gIlFzC8LeTkgO
	EuSvY10vuDx4t7tj2vo2AK6UKT6py8NMpVO4Qlat01L8MPX2mVLunl9pJSar1Y9IpcG0ISPT3Yy
	iS8ZilQMg43kszGCCKefeQOTU/Nzcq10SB5gyS4HFYUdxscrqxRkG/26GYq7gvET/wjjqNjZu1V
	34MIzfeyq9mkHas0U+blH+gN2UYqH2TAJ8iIHUJIYg3nwifvJ3blYKqNBO214+CLRpjGiOhx0NC
	B2mi7bqeOy+gUb5Al2Se3VbR9ll92Av99IUwi7lnp2qWlqoT7H4qSmACpGX9UCoOyAtdI6ynyF0
	8pzf0pjPBBRjbkk9fdWEYA+bxIKmTFb201cAat0kwfn0ic8Zj3hhvshcRd0Q9mPPrL4JUlrMTsM
	yOJ+rMWXCumD2Uu5BXrnNfPgFOXWNldbsiSnczsS9X3rSfirTWIG1BzeI8oUNYkKz9JsvUunYcr
	mI0i/30jwpOBHHFCqNBzq5Vu1pp5xLsv/lp3CDyYDXzJjSdIMq5JaiAohHgaDFUH8m2Oi8T4PVt
	f2ElmFmLeT7OFVMDoVc48vNwDpGJU/Ah98M3nwX3AY7qNYV5P91TyMzj4WA/HUn+SZ3DaU37wtF
	n+IaUSLCxtRANJ7LQ
X-Received: by 2002:a05:600c:190d:b0:4ba:2bfc:c8b5 with SMTP id 5b1f17b1804b1-4bb888267aemr218391455e9.10.1795425314064;
        Mon, 23 Nov 2026 01:15:14 -0800 (PST)
Received: from localhost (p200300f65f19a90438645cebc2ee104e.dip0.t-ipconnect.de. [2003:f6:5f19:a904:3864:5ceb:c2ee:104e])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4bb8538b09bsm626178365e9.4.2026.11.23.01.15.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 01:15:13 -0800 (PST)
Date: Mon, 23 Nov 2026 10:15:12 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Prasanth Kumar Padarthi <prasanth.padarthi10@gmail.com>
Cc: srini@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, joel@jms.id.au, andrew@codeconstruct.com.au, 
	ryan_chen@aspeedtech.com, billy_tsai@aspeedtech.com, neal_liu@aspeedtech.com, 
	tan.siewert@9elements.com, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] nvmem: aspeed: Add read-only AST2600 OTP support
Message-ID: <awQDxB-09pHSgfJ_@monoceros>
References: <20261121034053.39878-1-prasanth.padarthi10@gmail.com>
 <20261121034053.39878-3-prasanth.padarthi10@gmail.com>
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
	protocol="application/pgp-signature"; boundary="v6s5d2pxosvbykll"
Content-Disposition: inline
In-Reply-To: <20261121034053.39878-3-prasanth.padarthi10@gmail.com>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--v6s5d2pxosvbykll
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v3 2/2] nvmem: aspeed: Add read-only AST2600 OTP support
MIME-Version: 1.0

Hello,

On Sat, Nov 21, 2026 at 09:10:53AM +0530, Prasanth Kumar Padarthi wrote:
> +#include <linux/bitfield.h>
> +#include <linux/cleanup.h>
> +#include <linux/io.h>
> +#include <linux/iopoll.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/nvmem-provider.h>
> +#include <linux/platform_device.h>
> +#include <linux/unaligned.h>

<linux/platform_device.h> already provides of_device_id without all the
dependencies that are implied by using <linux/mod_devicetable.h>. So
please drop the latter.

Best regards
Uwe

--v6s5d2pxosvbykll
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmsEBB0ACgkQj4D7WH0S
/k7Hxwf9H/8q38Ueri9XT0N4hYnYWo22+INjgZLMlUEbSlxNQBDn1IF2w7mkk8Xv
BdxmX9P9vtKw5T3eYt0Ay8rnTIvrpCTlqxLAdjeAG35Y9i0teVdHBZ2NoruLywJe
o+SMd+vKFQGJIaPZpqZ+8l9UVMX7cw2f63hV8DDB/qOQGLOxUp+8+SMlTSh/0vpb
tdDetsWfXf3zXpUhcdm94FD344QDgGcl4xldzIYrZH3YFr+1yZhRgrSzHEWlg+GK
LazzxZYuxXq1ViTVixTB1tYWNiQjv/4vl/Vwe8zcAcpBwo1usnJXrObYY1gG+00g
g80CYxg/efXxv1fI8Yd2zVP5nAVxKQ==
=C1hc
-----END PGP SIGNATURE-----

--v6s5d2pxosvbykll--

