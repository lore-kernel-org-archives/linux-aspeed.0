Return-Path: <linux-aspeed+bounces-3638-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E9CBFD88C5
	for <linux-aspeed@archiver.kernel.org>; Tue, 10 Mar 2026 23:11:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fVqPZ5sGwz3bmM;
	Wed, 11 Mar 2026 10:11:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::e2b" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773133636;
	cv=pass; b=ZT8dvqIVtI7OuaX5viyOgvW0VQmnqO95wjksB7nsO3NzWBOitHF7LxoHfGbwby3e8W0gUJuvJ3mqeBp0uhqI5ZHIVss8hH/7cHYhRMUZiNmVOw40HwGJazUV+lkEXCs/CSeRRulLV2bsHLnq6UU2op4bKnjhaAXSZijoQu5NLn5zYgwlBAy23kwc2cvP9WzX4y480JEhxTSeL7q2EhDAbW6h7bx2riMiAd2IQpOLC1s0wNiTN7tGnodGearVAtFAymy61G6jMsERkCbp/kB6bMqSx2gC+Pi/jje5iJUK08jiUzh2VvxPbfMTP9ggXtG2iVuoeW5zwuW378MRpBzqWg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773133636; c=relaxed/relaxed;
	bh=B+nNz1AInMAO3E2JjYDfzpBLfMNk8UG5uq7SrYEhfjI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=imYX7C7hI9+K7q4Bq3VoYqe1yEEz/kxComi9Y4fU6W1D8IzviF037RiNS+ceWXDbSUb0WICceDzUlNI9FgqhHVennSDCSKEYlYLY+0DlAtMR/t8JpAi2Uw3WHrGOtvH8mkJlT7gADGrpoDRVGWSMcQpNxH3+8weTcu1yZO6gO9/RwgvSWYf9SMre/BWzZ85fjLJOCyRvOy7jbYps9Y8GkjMc49Y7ZT8G8ouezKF4Goof70IqPooTx64+ElP7WHxEGVuwn7a7XRc1/dehisL40SDNhGNUiWY7cnEwXD3ZRewQh74fslye2mfULlW8CJTdUugu5+O6Okm/n2qskmcihg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=iP6RJKos; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::e2b; helo=mail-vs1-xe2b.google.com; envelope-from=u8813345@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=iP6RJKos;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::e2b; helo=mail-vs1-xe2b.google.com; envelope-from=u8813345@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fVSgk5lXPz2yFY
	for <linux-aspeed@lists.ozlabs.org>; Tue, 10 Mar 2026 20:07:13 +1100 (AEDT)
Received: by mail-vs1-xe2b.google.com with SMTP id ada2fe7eead31-5ffe9a5b128so982327137.2
        for <linux-aspeed@lists.ozlabs.org>; Tue, 10 Mar 2026 02:07:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773133630; cv=none;
        d=google.com; s=arc-20240605;
        b=ZipfdcQcGkCg55jr2PhaMorMQ8sImxaNps/u72BVlCEQsBycVx8WtZlh5VGGsGTZ3j
         M9baJn3Eqqfg+75fwtO/K3Tp85LYir4U71hRvRqL0MYUEMl5efLt20LiI3xWJkephwaY
         I3D/cUEr+I4Q9GLikbbvkfRd/TspipMsYz4mO4kZ4AWd1IeeLiJVShd0h0/ufn/BCfYe
         vkgko0baKM3X0MyfbijrQleXje0PGYk6tXpiD4FcYUfbB5A1SuQiKM+bgxYrZni0H3uf
         dp56/3jNWAP5nAzlRycw5N3xO7ioEGE69p+ZNpWpTZIRAFbKDKeBZu833mYyXjD3u9Ai
         TcNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=B+nNz1AInMAO3E2JjYDfzpBLfMNk8UG5uq7SrYEhfjI=;
        fh=u2h2VdrVmD3S67eX967DgFL5cmJypfyncgNWxEeR0ww=;
        b=Ol2SHQkdR6BsQctl4QoJG8ofD8iSzo9eC1wYA+3U36ULP7Jv1b/7n2P435citjO894
         LSbu1GTa96KmE0IpkkxeLd7BWBlCvlpy4TSJ20qkEPFH0QRLdlFnFZXlMlBKjwaIn6WF
         1iOeIW7/GSGai7o4o9/fTA6nZ12ya+V7xyFBij/3afBuGBuKHweImgPBwkfJkP8Hk0xg
         pUz34SrNLraRyOSckwdZvIqKfNmQf6j3oly8sPRCwomUJTkVe2SUBnqMP/0Y+9rjPPk8
         pNWwYF2IH2cw1l6xWPXGiLC76q1PlZtX+4QzrwH4CPztdsRRzLrSfmO9I256NzWvjglO
         0KNg==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773133630; x=1773738430; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B+nNz1AInMAO3E2JjYDfzpBLfMNk8UG5uq7SrYEhfjI=;
        b=iP6RJKosGPKr82OI2/PYC0++DQqiqlelK4s+Lh+dHF+4ww+LDmnFf41c0g9FAu8ciH
         lGvGsVpB+s8vworxM1p8tWDjg//00AaUi+l5gyYB5lMOOoAB1/U0c9ph+plhFrEUmn6l
         1ec0cQFkb4thdEhNTn9lBfFDlWUqEdiHllCzkd+6pvJ/NSGp9sw4Qd+ArVDcNEVa2Khw
         Z5tY+czYl543qR5DsuuFHsdZWDq8AYaFRH0LbpRPct/237V97kWLStNwcUuU1EwEVRZ0
         MSWL29KfFEDqV9o+jIplIuNvDJpunqXOlhBA0ui93/vIbRl44ostZU37JWyWxlRy6I2J
         tQdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773133630; x=1773738430;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=B+nNz1AInMAO3E2JjYDfzpBLfMNk8UG5uq7SrYEhfjI=;
        b=JhkVYjvjZRzq14v781mTTMwZacjPzdOUS69db23TReceYZJ0JqcYQ55syS6x2Af4jA
         eT9rZrRKsXH91GAHcdBRHfqbTqk2vUi3VsbHyqL2Qn8cUI/Ps5V+l9+L5XhzEmuj2OIN
         3qMjB/QYPc2u2G8bnLSw8VQR3Gz2+jHLfxKjnej6h3jf62qYgdomCr1F+7dlHXakOmsx
         6ROaeIp+PQxhoP/c5gaILRvIlN3mAwZgFMoNfpuwBroHEldbQGBLYKN6AIUXCJeZYLuj
         PP14aWxaZ1tUGHH3UIwJCA6BU7zOc1ZrtaDJLbunQ4zZ90skFfLeIv33BG1jtVyaZPKH
         ujEw==
X-Forwarded-Encrypted: i=1; AJvYcCU9OEc9KoEGBT1UV0LcZGXreLJ98UjhcIQxrRAxvCyteo6fKE0Alj+ISKxJalKJ4gFwun+gohe0/UqvwZY=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzNmQG+cF58a89zW7wXL7jXWZU63VKFVsc/3cQ2HpblaFprduhM
	AUt4xaI2/xERwmrMM2UygdU6WL7IR7V4RhzZQouMvjMVwcPq+OsErZMhm1C950y7531SygbN7nw
	z6tHw7Oe8fBsldckTpEF4WLGt5bWfBmM=
X-Gm-Gg: ATEYQzz/J3DF9w6VnbALTgE/FvuBFiwqbOMnXyA/hXW+qP05vAc7WoMAwZPKSbZGvt0
	ZzEOMPrblKc/lRgvOtA4R6C12NlSIctwodcWRRoe5wonVtQu+zuWgth3FC42MIk9vHX+JxRfx27
	MhPDeoI6HwD5kRnUaS59JcWYQqU80ssqIzCIZv2VGiyZyagtj4yh6veCvgJHoaH2WvBTeBWJASM
	O1Oe1VRJyrgHvfYP1O+Yi/p4SkY9YwR3/5Ku8PNI6glOTb3NWj+ujLanlieMNLy+/QunFu95QMZ
	NITg2A==
X-Received: by 2002:a05:6102:dce:b0:5f5:4eac:cd2e with SMTP id
 ada2fe7eead31-5ffe61bf0c7mr5730209137.32.1773133630078; Tue, 10 Mar 2026
 02:07:10 -0700 (PDT)
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
References: <20260226-anacapa-dts-sgpio-v2-1-fd76828616b8@gmail.com> <3e9d0b356ad2871de0b3a47194726d3503ef136e.camel@codeconstruct.com.au>
In-Reply-To: <3e9d0b356ad2871de0b3a47194726d3503ef136e.camel@codeconstruct.com.au>
From: Colin Huang <u8813345@gmail.com>
Date: Tue, 10 Mar 2026 17:06:59 +0800
X-Gm-Features: AaiRm52146tZ5iflavx_AsTSdrRXnGzrXSl7eTyC_eatkyvt9sjGedxW7uv8FZY
Message-ID: <CAPBH0A-x6Mve=9C_4OFRCCQBfEr8e1mnjstG=EaRKc1wKdhuQQ@mail.gmail.com>
Subject: Re: [PATCH v2] ARM: dts: aspeed: anacapa: update SGPIO and PCA9555
 settings for DFT
To: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, Colin.Huang2@amd.com, Carl.Lee@amd.com, 
	Peter.Shen@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrew,
 Thanks for your feedback.
 I will separate more patches and remove the document name from comment.
BR,
Colin Huang

Andrew Jeffery <andrew@codeconstruct.com.au> =E6=96=BC 2026=E5=B9=B43=E6=9C=
=885=E6=97=A5=E9=80=B1=E5=9B=9B =E4=B8=8A=E5=8D=887:57=E5=AF=AB=E9=81=93=EF=
=BC=9A

>
> Hi Colin,
>
> On Thu, 2026-02-26 at 22:08 +0800, Colin Huang wrote:
> > This update adjusts SGPIO mappings and enables interrupt support for th=
e
> > PCA9555 GPIO expanders. These changes are required as part of the DFT
> > (Design For Tooling) integration and are aligned with the SGPIO signal
> > definitions provided in Helios_SGPIO_BIT_MAP.xlsx (rev: 2026-02-16).
>
> Where can I access Helios_SGPIO_IT_MAP.xslx?
>
> My suspicion is I can't, in which case this doesn't have any business
> being the commit message.
>
> >
> > Updates include:
> > - Add interrupt-parent and interrupts properties to PCA9555 nodes to
> >   enable proper interrupt handling required by phosphor-gpio-monitor.
> > - Correct placement of LEAK_DETECT_RMC_N.
> > - Update SGPIO line-name mappings per the latest Helios SGPIO bit map t=
o
> >   reflect leakage channels, presence pins, module power-good, and other
> >   DFT-related monitoring signals.
>
> Please take some time to read through the documentation on separating
> your changes:
>
> https://docs.kernel.org/process/submitting-patches.html#separate-your-cha=
nges
>
> If you haven't already, please also take the time to read the rest of
> the document.
>
> Andrew

