Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E50606A31D
	for <linux-aspeed@archiver.kernel.org>; Wed, 28 Oct 2026 09:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jEA64sgI
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jF2fR3wKvz2yDr;
	Wed, 28 Oct 2026 20:50:23 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::529" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793181023;
	cv=pass; b=Z+7GYXoUpID/LmD5TtNi2Zjd3gCctQrvXbbNCEE0f4FkbCNCROWXNCeHbPziEM0x9WFjmLDZOojHb9sw+cS+9juq/1MNDqN7yAakUehFVK8nizS6iYEOcSmXlhcwNZhrbPjOHoCTL1rXEEpaeaUGC9V2zWu4X6QOUK6tjtficc1OUXv4RkUL+GhMXwvj19HP8Vr3R+V87USPcrWXp4EhCCYc2g+HnzM1RVQ7I+Yk5uyWJGuova7ZmJ8lv9xnFnBkuLTpEvCWfzrEMHfha5LBaFo/7MJ3ybencNz7i4M+gvyr8wfAhjYDCC7n/NksR3lbptqAyHWRsyXTKlbSPB9uDg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793181023; c=relaxed/relaxed;
	bh=OncitmhmKPxQRhu8FlY/GIP5U4Gt08ht3PeyL8T2LDg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bkrK3A8B4NZyii05IVU1RaUMOWfpcnCS/MwvR3aiPSv3ucKoCNEiiaC+uOcXJxGCpHr87qRbO2CZRavAby8u9ISpe5QJD2tG/ma52x3J7a2uIT5CQGX98Sddwz9fYtgf3njf6OKrpHxk20OF3BlimPbzQVVjy27JjO/AMXVV9MxW58JTIdBfs/roPmpCmkP/IkXcgzcNgnyqlsHcVJbHtYQm3nlnjCbbwPcwAiH8l4EC+Z0XnzB6pZH3Eo1eBkzPNzPx8tMRGjgkQ4cH39f4voJviZlw5zOchi+l9r/xCsATo3Cpw67dRtyWnn5eTh1TnCGA+jXpDDGFUM1WNEknNw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jEA64sgI; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::529; helo=mail-ed1-x529.google.com; envelope-from=andy.shevchenko@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jEA64sgI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::529; helo=mail-ed1-x529.google.com; envelope-from=andy.shevchenko@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jF2fQ3Jz8z2xlj
	for <linux-aspeed@lists.ozlabs.org>; Wed, 28 Oct 2026 20:50:22 +1100 (AEDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-6b1f31c63ebso3106058a12.0
        for <linux-aspeed@lists.ozlabs.org>; Wed, 28 Oct 2026 02:50:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793181019; cv=none;
        d=google.com; s=arc-20260327;
        b=R2b/hZ6i0K1ijHyR45eZCrIK8rg64Sm52igIXzegzBc5fLo4qGGNeZsqaYSEhWLOC0
         9WkVhP0bOLkPZu0hBvY62YOkwhC5mLkydeTNvyOSllHYNTot43D+Ky9D0t4cJH4DOhJ+
         OJ6Klnr7NiNm1Ts6aGP5GDSIIlW7X4CDIbfUtG9q0AjieTnZ29kSudewj571x2kktRu4
         ANuieEhaMla3HOnTzkClfzWBhYFJ9aWHJv05Xk0osVCz9fqv5vsM0aNePtxsRW/YYO+Z
         2KKvgjqLeTiqo1L1HXy4aDiRCm0920607qW5CqiHcM5kbIyh9eXksDQcUYm1AFiti7cm
         lDJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OncitmhmKPxQRhu8FlY/GIP5U4Gt08ht3PeyL8T2LDg=;
        fh=5p5P6W/wdQV2Krls34v173yXfTg841wB82/E6NM+lXQ=;
        b=VllfcuI8tixvt/Qt0LVIwgSPcwozZzT5Jo1H9mnFKoh16kE3bV4HO/1VbYYfutTTRa
         ebIp+zJ78EMTRGNSK/PWI/bqU/tmlvcSmOBlx4hVlclj9yPEyKPqRk5cRir3jkcM6yVA
         8s33FvO6ZpiuLeW1Ab3NnSo5OZIWOW//8mQZvtFc70Gz9Tq4GzivdMnsmvctWQSIm+Te
         bR/TsYg4e+YrY+TEViH4jWKY+SmeLt1n6Fb5KMAKGRhHm336iN0V1PfYT4pwNwkWslgQ
         lfEDTIsV7Mt/xTSxMDJ6sGqzhBmIPnGCd2GytjTI69QlfzyUXPCuyUBRPtoMMnrJAMO4
         /dSw==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793181019; x=1793785819; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OncitmhmKPxQRhu8FlY/GIP5U4Gt08ht3PeyL8T2LDg=;
        b=jEA64sgI98qQCgBIXkmW+JBodCHSToc+udUXrinrMM8LudZra1tcQDbRxmyxp295oj
         sdqOOM/eZ7L2Rcmu+icbz5zNkBvPZwFIT8gQ18YgVHtYVT9bYOOySQz2v+96Ojxm1cJr
         Fvi/iOFrLtyV0bZJ5yCAH+2yyjYtoNU1dt0bUxQQJX+oHlz9x7DSKYUJ3qFfG9D6iNrf
         W3LpR0V/HaEnHBS2TxnnUq07OFDhBU1ZYLjiDngvthHHMsgiNhv4MsGUzLvgwuIewfeK
         kZSJ5hGVZcu8fRhxt82Gut7LgdYyc8V8rzoRwgPpw54I5y3WXcywUJw9cEUDMAXtD3ve
         EOHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793181019; x=1793785819;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OncitmhmKPxQRhu8FlY/GIP5U4Gt08ht3PeyL8T2LDg=;
        b=uOQa/OORola5koTJMhDaXk8r3IDQLgTQptnqoa8FH0i+2NPgSjD/D7BswhwwWW0CNp
         d/p9XfI93oD8IDySiDd52UhePbc+ele4g41tUxpXcJvc1+6dKISbEAq28dV42ESWVByB
         drUdlOHxv9mccDd8BgzQeAMZ0k7CSAVtWtV19SyIE0/TzDabAXDTSdVd7dERFNtGVmsc
         IoxMWqTyYrhrKuV7HRRUxEZRlsX+P0iXyWtbMS9Y5H0+1XvIpXc5aCD1NUmPqRzAtT0x
         VOGbnf8TuTViTAEG3e2sLudoBxuaIh4Bg0LH9ZcSZZ+lFbh/Gw7ArK+pIpTYpmf4mpfp
         imGw==
X-Forwarded-Encrypted: i=1; AKwUvBwTbPZma9AVWyJucPcmA53kzun+dVHWhmF+InSEdGONASbaiDoXqp/Vvmv7hERv3BY8IxSX647+GWrQ44Q=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYL/+7oB4Uiaef4hsU53bimMm1LRJ4u+A3wySba2UJNb7O2U8YT3
	HZxsR+lg8cR593Vg5kvPTT2rCF6schOq06hmrw85B7NgqZvCxJTuSXGPydmZ5erk4uFTQsVexBt
	+SDDfzhdqR7yInUDVCoWGofLXfPm1nBk=
X-Gm-Gg: AYBFou1oDKlx8J6boVkHi0TfdbSYyX4s9gTWRqXPFR8SUXq+K+6s/bDNI7N9rKkjzfs
	TySWs+Z3V5/KinY8iCsoTh+r0yH7RtQtqQRhbMU9fyiCc7SH/84UeTX4q6uKKK+IPuzpXzRYi+j
	c8JmAMOA4uLCPhVHF3KOM+dlMLzDqde9RJBHvMcy9V9Qbf+skXciFcbBCFYJ145J2wJNK597+Cy
	6xeSPoVCLDCX4GFdfBh35yKITimKTYTvlL2VQD0EXhe9KiAv8aV4uVDhUNk1bkNHvYDE/dtvCvm
	GCueN0hFNjWap2iVr1rRdXU73VehatER+J1o0gn5Zzm9ZTLbfGqfisENg5WJS8JrhjdmBnUZ2KL
	zilRhgTHuaDQtQ67+58xpt2L4Upma2yRbbvhnelZ092bny8pq64hoiX95qaL1pBd2aA927vggYv
	mXmiYBw4LtuxIT1t4lirbXcB/crm7xmkeQDi7r5DGioLOB2nXNgyQ7pQr81K00+UrE++lgOTOPi
	Q5MFKxMarq2OTzWrnUKybj5Ihj3on4vqX1vhdZENBOTOEY=
X-Received: by 2002:a17:907:86a9:b0:c48:a838:c17e with SMTP id
 a640c23a62f3a-c49a739f8dfmr484567766b.14.1793181019107; Wed, 28 Oct 2026
 02:50:19 -0700 (PDT)
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
References: <cover.1793027261.git.d@ilvokhin.com> <33ec8080594f9f4ef1d50e36497339c9a6897393.1793027261.git.d@ilvokhin.com>
In-Reply-To: <33ec8080594f9f4ef1d50e36497339c9a6897393.1793027261.git.d@ilvokhin.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 28 Oct 2026 11:49:43 +0200
X-Gm-Features: AclHuK92we6zl1A1tCfKfYVeuXltUG4Bsfa-fRzr4orRkDVhJuYkTUAxt0MOtcM
Message-ID: <CAHp75VfR2i_PPZwSG2UPaxShU5L=FsSdEAT+0iUMDKAfugbRsQ@mail.gmail.com>
Subject: Re: [PATCH 05/10] drm/i915: switch to __nonnull_args() macro
To: Dmitry Ilvokhin <d@ilvokhin.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Jani Nikula <jani.nikula@linux.intel.com>, 
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Tvrtko Ursulin <tursulin@ursulin.net>, Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
	Ryan Chen <ryan_chen@aspeedtech.com>, Billy Tsai <billy_tsai@aspeedtech.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>, 
	Matthew Wilcox <willy@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org, 
	linux-leds@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-hardening@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Oct 28, 2026 at 10:20=E2=80=AFAM Dmitry Ilvokhin <d@ilvokhin.com> w=
rote:
>
> Commit 22302af28d3f ("cleanup: Annotate guard constructors with
> nonnull") added the macro __nonnull_args() to wrap raw compiler
> attribute.
>
> Replace __attribute__((nonnull)) with __nonnull_args() to standardize
> nonnull attribute usage across the tree and keep the attribute's quirks
> in one place rather than open-coded at every call site.

Reviewed-by: Andy Shevchenko <andy@kernel.org>

--=20
With Best Regards,
Andy Shevchenko

