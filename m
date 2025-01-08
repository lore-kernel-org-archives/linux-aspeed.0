Return-Path: <linux-aspeed+bounces-352-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A44B1E77199
	for <linux-aspeed@archiver.kernel.org>; Wed,  8 Jan 2025 12:55:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YSnwC1sj8z2yNs;
	Wed,  8 Jan 2025 23:55:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.160.43
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1736340955;
	cv=none; b=Q4zQOP51q9DpD3BZEw3d3bG1dTJq3FPicVIHbNIr5MhFtOcYRn9qdwxiXVVBQrl4xskP5d9rHxB/Jz1SBOcNwSh6UFCjNhQ9A+wCQmjnMdKbuvXm/VphH5Qo5nryuTHYHIEgltRjr3DRUHWem8pWG20tKy1VPsNtI3Q5fF2HSMN6z7gAL5wRX55GL62kjlJZjzPaIbwG21Vg6Gbs1K6ugYVabv/IkzUSMRklbArDkkEuE728Wx6jYPNQbU3FOkkF0v0z680+vapCj4R9tqANS+iC1g0DqQ+C9ZgQlRMaInYtBFE1rMQXxijSn96enlReWMRGxQ+ve7E+4pm1AJ1zUw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1736340955; c=relaxed/relaxed;
	bh=HUpdZqfO185onp0pw74RHuTZBmHqg9gIbSRVhApYVuI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XVO+RMl7Eclj8IJ3GqSfh6W23TYwBmS8sHPpEl67vegzJDDAVcvR4d4nnBT/wRQ7xdsWT7T9hb0DZTfF9LyRc4RDRCkx35x4aHxB3oDKOknIM3UMQ6mCsPsCFaWECzwCPXfDkSz9fK9jDa5cS42jXqtUs5gLLhaNwOPPjtclvxWGSaZ/vflDzHBtvK2KY2EJHcu/aiA45a4Ig23oX8pKiOhR1iLjNjZjz0jWyW09I8z3/m3u9yHEgnMI9igkfwdkjQHqEeQ1fZoGWV4HqkoxtYWVX5urTBVyqwWmpY6CRu2on5XhuCr7LLVh4f+mt8dLLAVmREx4fnnqJOxe0Ic8lQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass (client-ip=209.85.160.43; helo=mail-oa1-f43.google.com; envelope-from=geert.uytterhoeven@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=209.85.160.43; helo=mail-oa1-f43.google.com; envelope-from=geert.uytterhoeven@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YSnw856tMz2yMD
	for <linux-aspeed@lists.ozlabs.org>; Wed,  8 Jan 2025 23:55:51 +1100 (AEDT)
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-29ff8053384so7654758fac.3
        for <linux-aspeed@lists.ozlabs.org>; Wed, 08 Jan 2025 04:55:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736340948; x=1736945748;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HUpdZqfO185onp0pw74RHuTZBmHqg9gIbSRVhApYVuI=;
        b=CArCdYfHR/kwhO2EyvV4XdybvPl2LGqiSaKaOAYyDu0n75goTjhpw8uahwASBPYZcJ
         nUMoxFy7CviuoTeBoUy8gMeuuxlsrHxxcfwoFIqsiSjnPEP/DY9sjpyfjQ7c9VJ67zav
         oIfuB2WLQ/ApANgJo4bcSIPfL4J8DvciLDfZDd91rrybkOjQc2S7FWutBfaSyrRb7RfY
         BMtjdTkz6x0tv5Es3Vdzeu2WBhLqDSLQba+ma6r9Ysg/q/ZENTVXejr/NZW1pcSKeslG
         pL2vkMW71MWwi1hRxpzNigq6NUtvuqC3RNwEPPOM/OiMkcPPU7n/agmeulkqDMVCfHNs
         4I3g==
X-Forwarded-Encrypted: i=1; AJvYcCVlpMdAmCTLWQe5Mbvl+EtH12r/sy8/LmBtxxcgcjvv4CbAnC11hAIBZ9u8hQFitPJHjX0zoOmVStGn0GY=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzQrkhHwM9RqTihFgv4C51mmUid2fXEdiQh6pck58nTgtQYrb2X
	GUbUT8ru09givFREOB40lt+dasHDI4TaUC6ZUbtogPuRv9YO/O/xqmz127mW
X-Gm-Gg: ASbGncuUYWuDHRy8SURP33hVBubK/1crqlK97/tUYWg/ttC3bOlFcX2g7LVo+LGEc2Z
	tXdS64XSzqVl7SDU3dhtLnR6wwRDjkRwhVHFszr/ZNanTBJ+vitf5avhIeMCeTIuJQMoOVm3u2l
	OytJi2ZQxdeVagOQMLN/LIBAFgJEcTY2K+AskHpr/WkL1+MZlMikgOYdqaVPgH86iwOuRx1xE1A
	1946RRsZs4pYT93gFHUpwUw6XokYir0Dv9tE/jAc3iUeS6CYeQXTptYMVf7aKlagZnelw5z/UHY
	/05dO7r8+BJku32GCYM=
X-Google-Smtp-Source: AGHT+IF/amsZ4WQXYEaKTUiphqbtt0jZ0HeoZi/HKSwHlu27vp62BuDulBIaitC2DJSJEh3N8H9ugA==
X-Received: by 2002:a05:6870:6b0a:b0:2a3:be8a:eebb with SMTP id 586e51a60fabf-2aa06983781mr1277219fac.35.1736340947630;
        Wed, 08 Jan 2025 04:55:47 -0800 (PST)
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com. [209.85.161.49])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2a7d74bb9fcsm13288073fac.12.2025.01.08.04.55.46
        for <linux-aspeed@lists.ozlabs.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jan 2025 04:55:47 -0800 (PST)
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5f33d944ce0so11371363eaf.1
        for <linux-aspeed@lists.ozlabs.org>; Wed, 08 Jan 2025 04:55:46 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVjVibgTohQ6Is1YcWJQM2WPLBPM91dzEStYnZ4RlN87CEqLisIGm8mbvgClfsOeFo59+4395JUaQTQt38=@lists.ozlabs.org
X-Received: by 2002:a05:6102:e10:b0:4af:c519:4e7f with SMTP id
 ada2fe7eead31-4b3d10485b5mr1502790137.18.1736340575232; Wed, 08 Jan 2025
 04:49:35 -0800 (PST)
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
MIME-Version: 1.0
References: <20250107131015.246461-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20250107131015.246461-1-krzysztof.kozlowski@linaro.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 8 Jan 2025 13:49:23 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVpDWFt+3EBeiGfia3DXDL+LNg976FBm32vNEnJdSx4uQ@mail.gmail.com>
X-Gm-Features: AbW1kvaX9wLk6edIIBJWmWkhpdJHnfaq_7CxFB_flrYoOUJ_oqU6wmphd1LCLQ4
Message-ID: <CAMuHMdVpDWFt+3EBeiGfia3DXDL+LNg976FBm32vNEnJdSx4uQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: usb: Correct indentation and style in DTS example
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
	Andrew Jeffery <andrew@codeconstruct.com.au>, Justin Chen <justin.chen@broadcom.com>, 
	Al Cooper <alcooperx@gmail.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Benjamin Herrenschmidt <benh@kernel.crashing.org>, Florian Fainelli <f.fainelli@gmail.com>, 
	Benjamin Bara <benjamin.bara@skidata.com>, Bjorn Andersson <andersson@kernel.org>, 
	Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>, 
	Del Regno <angelogioacchino.delregno@collabora.com>, 
	Tianping Fang <tianping.fang@mediatek.com>, Jassi Brar <jaswinder.singh@linaro.org>, 
	Biju Das <biju.das.jz@bp.renesas.com>, 
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
	Francesco Dolcini <francesco.dolcini@toradex.com>, Macpaul Lin <macpaul.lin@mediatek.com>, 
	Alexander Stein <alexander.stein@ew.tq-group.com>, linux-usb@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	linux-tegra@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 7, 2025 at 2:10=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
> DTS example in the bindings should be indented with 2- or 4-spaces and
> aligned with opening '- |', so correct any differences like 3-spaces or
> mixtures 2- and 4-spaces in one binding.
>
> No functional changes here, but saves some comments during reviews of
> new patches built on existing code.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

>  .../bindings/usb/renesas,rzv2m-usb3drd.yaml   | 36 ++++++++---------
>  .../bindings/usb/renesas,usb3-peri.yaml       | 24 +++++------

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be> # renesas

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

