Return-Path: <linux-aspeed+bounces-1513-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F496C71155
	for <linux-aspeed@archiver.kernel.org>; Fri, 20 Jun 2025 06:52:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bNp7J6xxlz2yf3;
	Fri, 20 Jun 2025 16:52:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.217.41
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1750402332;
	cv=none; b=SHH1hh3Z475BvqmLBCeVSqvvho8oFa0dwVtsJws9tj9+xvS374M8cyD8bqIPQDSvw+M1DZN91Jxet9Vbr87msfGqQJUAwcBtLIlPTOetRGYR8YEk2QxEqt695KjJC19k2momc9dWOhLyAT8VBE+JMUaoOqUZJsj70ywlOXipsTByfr16OnziUnVIiGc2IG6BPQSUPPBXQLU/do7mZbVw8lBCp/nDlP/uICfUdrF+zHg/KV+P6WHEnBvdeeLB24yRjYGBkpXBPCTaiyBBsPiOanYTDU/BMMlJO4ujeISu9RJQbUV/j9EnskiEh4XHE/UC09q39ZcP7x7erEQwoqK8yA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1750402332; c=relaxed/relaxed;
	bh=gEssu/NXd3Hla7QRE6d+TVGXP6/YrFjxNAC/07Z4Nvk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LzxCaIZk72yhQEgeGJI/hz53ArMBIcvDl56ehm6OSsI/7EHXmWTnI74btoY4WPJQ84SkwtrI6NxXz5THdS8e9qFsIU4AF6jjFyHon7BNFoZ7FEPYhoRwrWq8UjXu7yGDWPa8RPgQT74+NHYjQvqiFpQ3wO3xR+FRCcUDjbAvQFOMNoBwTuEMNlrMUHL9QUbF+S3bwvMZQcGl0F1cS7t5n01EfoNelivdfF2WeOpEkx5VU18CNaBlczu8vW55fw+VnNnHZiEAE2YAce7ijXiEdJqxJ91qLRWNTvBW3pdGeONhjf3b6y+5jMUU9Nww0i63os88DJkWL9f6lf9J0ni0FQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass (client-ip=209.85.217.41; helo=mail-vs1-f41.google.com; envelope-from=geert.uytterhoeven@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=209.85.217.41; helo=mail-vs1-f41.google.com; envelope-from=geert.uytterhoeven@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bNp7H3LsKz2yYJ
	for <linux-aspeed@lists.ozlabs.org>; Fri, 20 Jun 2025 16:52:10 +1000 (AEST)
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-4c9cea30173so405111137.3
        for <linux-aspeed@lists.ozlabs.org>; Thu, 19 Jun 2025 23:52:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750402325; x=1751007125;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gEssu/NXd3Hla7QRE6d+TVGXP6/YrFjxNAC/07Z4Nvk=;
        b=WFFqsVMbujM9oDkEdE5pYQ29GjUKnRzGCeb7W4/G7unDIPZ6A+ag3RrtDwg/BcQiAT
         Yrt+7Dhd0WFbTv3lI/GgsKgDeSfSoh0DURhSqEVQQ6wJgwsvQIQGkJyDMWBVPlh8lCyn
         sj5b5jYfqu1thQnJ3Fp406X6eIyyVFw6cyd14eyPgXVCF9lILSy3eGC+uNw+qY/dB7oD
         jDdRzQImy3+YYxMsqzwEXRYygavTADWplLoxawp8Z09bHup+V7dFpdZsUokof1PVboiG
         rPoWqaNNRHRL9yDkQyJc7b35nAMCkeruTb0LwpMzTxK9oW++mue/gx0XxxF3aaEnrBWS
         KYvg==
X-Forwarded-Encrypted: i=1; AJvYcCWsicH6/d0Xiyy+MtDUvgMt++N9XMYG6KSD6JTw6cM+6kahOzxuOsvsK4MIF/PtQI/MvNu1k7McWA/XH0c=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyTjepmVhZJyL4EEYXpEXzLPmsCOtC23+XSK3yF52S9JJ98EMtQ
	6mf7htRliF1gZ9aXBfjJADhaUUjbHWrp5aLQtLJ9Vn7cqrVkqmeld+oc2mCGPMYl
X-Gm-Gg: ASbGnctHAhTCtztsi4jE6O0CRtxnWvhdi3JdH+PI07TKXBSo07mQxrsOTcQgNlYvC02
	4XddObwpNi4sRGKsDigvrnXLyEdkVVYom3ozjfWehGQtLs5deghvuxJIdTdDxsiosmq25672IjQ
	IXuKvrWeWfskPZpe9F0Y+WqDegvGiGOAWFHYMtgaUkStAx9eDBVJZ2IzxCtcTYUXo0wWboK9aXH
	9I039PvVvNcMDVNLVy46osw4kaPG3hnrQ2X6mWzKKotsXcgd6v/lWbwYDuA8gmohPx47gvWctdR
	5nFgpFBIIHrPVzpP418PQQvkNbvKE0pM9ANSpBn/m6+CYY+kmCRcxTHauTCKaEstvXuHX6TOnOF
	3z9BXAc/6Gu/js9RydAWn7w/Q
X-Google-Smtp-Source: AGHT+IEGMAXbtRhEem036xLvZWG1MhXvhZ5psIRoXheiTSdjsq6NU8PIlv81tESx73gu8OyPrYpptQ==
X-Received: by 2002:a05:6102:3051:b0:4e2:c6e4:ab1e with SMTP id ada2fe7eead31-4e9c281661amr802737137.7.1750402325444;
        Thu, 19 Jun 2025 23:52:05 -0700 (PDT)
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com. [209.85.222.45])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-8811acf984bsm204981241.4.2025.06.19.23.52.04
        for <linux-aspeed@lists.ozlabs.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Jun 2025 23:52:04 -0700 (PDT)
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-87edd8f4e9fso307702241.0
        for <linux-aspeed@lists.ozlabs.org>; Thu, 19 Jun 2025 23:52:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCULqJ4OdKHl3dmcr+0PuA8YaFmifr9vEAp7TQxmjW82fZsh/8HlKvj3jZxjs9Jlh5/B/LGUzwfO9T/1T58=@lists.ozlabs.org
X-Received: by 2002:a05:6102:c4f:b0:4df:8259:eab with SMTP id
 ada2fe7eead31-4e9c2a018f3mr788689137.19.1750402324049; Thu, 19 Jun 2025
 23:52:04 -0700 (PDT)
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
References: <20250618-add-support-for-meta-clemente-bmc-v1-0-e5ca669ee47b@fii-foxconn.com>
 <20250618-add-support-for-meta-clemente-bmc-v1-1-e5ca669ee47b@fii-foxconn.com>
 <93c91bda-9c2a-4a23-bc35-a46587077621@kernel.org>
In-Reply-To: <93c91bda-9c2a-4a23-bc35-a46587077621@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 20 Jun 2025 08:51:52 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWDbp+d=o8F4o7Bw+0am7hBFcKsFNjithgZtHx2bvpMHQ@mail.gmail.com>
X-Gm-Features: Ac12FXzy1twp29mefSPbzAxxpzkqUQya2cqJCrjgKLlCdSDLERYoEPvlqbB8GoA
Message-ID: <CAMuHMdWDbp+d=o8F4o7Bw+0am7hBFcKsFNjithgZtHx2bvpMHQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Leo Wang <leo.jt.wang@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
	Andrew Jeffery <andrew@codeconstruct.com.au>, Kees Cook <kees@kernel.org>, 
	Tony Luck <tony.luck@intel.com>, "Guilherme G. Piccoli" <gpiccoli@igalia.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	bruce.jy.hung@fii-foxconn.com, george.kw.lee@fii-foxconn.com, 
	Leo Wang <leo.jt.wang@fii-foxconn.com>, Conor Dooley <conor.dooley@microchip.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 20 Jun 2025 at 08:37, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> On 18/06/2025 11:40, Leo Wang wrote:
> > Document the new compatibles used on Meta Clemente.
> >
> > Acked-by: Conor Dooley <conor.dooley@microchip.com>
> How v1 with such subject could have been acked?

The "real" v1 looked better ;-)

> Please provide lore links.

https://lore.kernel.org/all/68240d47.170a0220.ba589.0feb@mx.google.com

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

