Return-Path: <linux-aspeed+bounces-4325-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 493EFC43458
	for <linux-aspeed@archiver.kernel.org>; Tue, 30 Jun 2026 23:50:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gqfzX323Gz2yb9;
	Wed, 01 Jul 2026 09:50:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782820387;
	cv=none; b=ccZfX1eyks3lLu2n/dig5Hln3kLXYzDXzzc2u6QmJ75xaOQogtOe7MDwZAdQbCEgSi/kKWgWefntAkTBL2UzbEIiTOe7lzoL9nSVclz9qN6E+7BcopiYAWJfx4/IlpsereFEACw2/uCjGtqDJUewu5ycpZZEW2AvHr1RRbPEkbn3VP+BGa0UBgGHMc/JVi+1JWMu9ZMCgL5g9n5IOznj8ZVMFJeMidYAZWiflNzUKd6ecB0UcD+EuNw1b2UyY7l/CVMZ1Fpd/9cDGdsCI2yulsF/uxpJLuFpP1S/boY7nNmmonPCHa2BGrpM234iPTGgmifax6/YMlkdOx1oWk7/NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782820387; c=relaxed/relaxed;
	bh=493enOlPSgfL8Xi3QDIl1rddbYGRJGRVQ1cUt/F2sHc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YjxV/SqAkjJFAgJyLUfeCpJUlUDEsSsxKMOlalhAPcB885hW6TkkRLaLxHG1wmDErnX8v6uLBcDsK2HkTrHFT4pFf+0OA0SVK8rU4ERl6Kg5GXtZ4xrca4cgCxunbjicWynt7eMfSam+MUC+G8PAb/5dvyw8C684HK8hi1sJrsAWYg1K0arsjXYy+4EZ20qZ+OLkxFA7h0KmODWben+/DxTrpmattmDiDMZANjT8l357ox0Ux/EvNHoFwGCtnCSelAbKJ61GcG1yQ0ea2eCcTRMGtK9RTmG9oAXmH8JV/xYON1/571HTyIP3K6Q8kHuDxi3+iFyHonFbpW3SMjRAVA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lrlJJAyQ; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=linusw@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lrlJJAyQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=linusw@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gqM3Q4Xqmz2yZ8
	for <linux-aspeed@lists.ozlabs.org>; Tue, 30 Jun 2026 21:53:06 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 28B5A41321
	for <linux-aspeed@lists.ozlabs.org>; Tue, 30 Jun 2026 11:53:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DA681F000E9
	for <linux-aspeed@lists.ozlabs.org>; Tue, 30 Jun 2026 11:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782820384;
	bh=493enOlPSgfL8Xi3QDIl1rddbYGRJGRVQ1cUt/F2sHc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=lrlJJAyQZ3DwijrvkQSaLW/aK3tq35nYYm/c5Fotxi0Uq/sxm/MTtkXjQNgg0Fgxp
	 KeYk1xrd8xyH45/0n3famjiuhyGtB6ePQFrOG+P4ANJc9Ou8bDFFyq+PNnitfddnlu
	 nn8vBTyx8KO13fiCz1xG/2id40eL/RmVJCjK3vGEmGii8y2HbrdEeYthuisNvkEIXh
	 CCCVjANnb6ziEZe65ted0H7vtlp+DAVwnUfFYjeCgc3a3U6n7+/78RExC2z3Wm3HG3
	 7kx01Gi09g0a+U5y8Tp+vSCr7ClStQFBUwDMXbdFuGNBF84FtfwlnzLaY2irwtKLJ8
	 R7rE517rnSYuw==
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-39b28814916so1461721fa.2
        for <linux-aspeed@lists.ozlabs.org>; Tue, 30 Jun 2026 04:53:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RoHnPCTa1nIGLHHXG9Lh4NZjFT1ifXEh+WviQbJ5w2kEVBulaefM0QN5l6Mf59XdQOXn0veHTCuk8qC8vs=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwJEG7amfIvYApUVQaHCR/AOsIlgfpRwEF6noojOhG2Hdlfg8D2
	EBcOrWAWz3T4W6lUuqIFietX/GeXWptajScBKRdxxIJ3ClCwXbCN8mNFUoE6DEKxzAXRRQ74+AJ
	mluG8txHIC/V/9BbTNehCJU0D0vmEo/s=
X-Received: by 2002:a05:6512:15a3:b0:5ae:afec:8afb with SMTP id
 2adb3069b0e04-5aebdbdd0bfmr741396e87.48.1782820382868; Tue, 30 Jun 2026
 04:53:02 -0700 (PDT)
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
References: <20260616-pinctrl-fix-v1-0-621036e45c7c@aspeedtech.com>
In-Reply-To: <20260616-pinctrl-fix-v1-0-621036e45c7c@aspeedtech.com>
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 30 Jun 2026 12:52:49 +0100
X-Gmail-Original-Message-ID: <CAD++jLm3-5BP+1E_DLTZvEPd1ugMZrXiOjM+Gqnn9Ri+uNWuPw@mail.gmail.com>
X-Gm-Features: AVVi8Ccukh9jeKMJzDntWFmdET_gKKyPu4vZydSTvGPFTsmFqpaNo79r5YLA3x4
Message-ID: <CAD++jLm3-5BP+1E_DLTZvEPd1ugMZrXiOjM+Gqnn9Ri+uNWuPw@mail.gmail.com>
Subject: Re: [PATCH 0/2] pinctrl: aspeed: Make AST2700 SoC1 JTAG master TRST optional
To: Billy Tsai <billy_tsai@aspeedtech.com>
Cc: Andrew Jeffery <andrew@codeconstruct.com.au>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
	linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org, 
	linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 16, 2026 at 4:30=E2=80=AFAM Billy Tsai <billy_tsai@aspeedtech.c=
om> wrote:

> The JTAGM1 pin group of the AST2700 SoC1 includes ball D12, which
> carries the TRST signal. TRST is an optional signal for a JTAG master:
> designs that do not wire it may need the D12 ball for other functions,
> but with TRST embedded in the group they cannot use the JTAG master at
> all.
>
> Split D12 into a new JTAGM1TRST group under the existing JTAGM1
> function, so TRST is only muxed when a board explicitly requests it.
> Patch 1 adds the new group to the device tree binding and patch 2
> splits the group in the driver.
>
> Note that this changes the meaning of the existing JTAGM1 group: boards
> that do use TRST now need to select both the JTAGM1 and JTAGM1TRST
> groups.
>
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>

Patches applied!

Yours,
Linus Walleij

