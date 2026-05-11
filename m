Return-Path: <linux-aspeed+bounces-4010-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5A7ACD4855
	for <linux-aspeed@archiver.kernel.org>; Mon, 11 May 2026 23:51:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gDxM90JGdz2y8m;
	Tue, 12 May 2026 09:51:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778529955;
	cv=none; b=jQ0vFIxKEp2DNrG6ca8ufuiZpmEbpv/Fl/fSaH14A8cYL2PLHIUk+Sm11oD8OioXgH88noyVFmYoKJZ79g2nxjd2a6oISQtWBtAArOOtoOZmYGQ6agGIIp1hyaolKh3jH7aO0Ad774KdVGIuTLUpd18+n+I4ZJhKKvaEM9ITdDNDL++ui3y9YmL8MqHxkagRTrWc6teIw4cd0vIBN3ptWb+80TEbmzQtWeq+g4+BqwHljzo4M2At/yvJAKhmL+rZjRaG1/zAxkahhXTEjsJEdOKNvDWgZjt5+Kr2t1DlTWRcUyaOC1XqRXTf43kTEJHoQa7OAVg09m0BPm3b/o4uUg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778529955; c=relaxed/relaxed;
	bh=2Xsowmeu2RyzTVACoqAzvMX79fACSIN87yT/5+JNn24=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S8bMkuLkVscCChQ3xaqvtAOJ2VGKFiQPKPVvIX3ksiLTgItA4t4cuepuUS4D1oEPSShRHkN4y2Wx8ZebDq4znFlYsW3CL7I1xDoXKGx8d6rSFMt2a9xD8VQkMPaUjPZo9564+hk9lN6FsOSNq0SPJFxBKt0NEcloWRtB8f7yw9fSi2ombBHXC4KPa8pMlpz7RfQt6OqNx4iwin2XHunjMFHhs5xgmCZ5Zgiz+vNKLQNpPFP+NvikLI5OVoZd6IAue8GhjacQ8axcAreU/+wjzwk0abp7FDr4DgwlZ9WkaLNVMBn4U47IcBtjykfxtVK9p1LMxBzYMk9DCwqqoMw14w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ut/rzfkE; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=linusw@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ut/rzfkE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=linusw@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gDrM71jlPz2xSG
	for <linux-aspeed@lists.ozlabs.org>; Tue, 12 May 2026 06:05:55 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 7A87042D65
	for <linux-aspeed@lists.ozlabs.org>; Mon, 11 May 2026 20:05:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54B86C2BCFC
	for <linux-aspeed@lists.ozlabs.org>; Mon, 11 May 2026 20:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778529953;
	bh=2Xsowmeu2RyzTVACoqAzvMX79fACSIN87yT/5+JNn24=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ut/rzfkEkxSQVJ7hvg2gtO6RIoATawPoLO/LzBoFHk1N3oMedL7fWii5dcdw9dz6b
	 J51kg8bIAGfkyUvBmduu7zpL6FKRE22Zr5QsHn0BtEZuGshRBbXLv4WjMdSyPQdgvT
	 OeUDgJMgA6DsdYZ6YEhEPRHYYZwa2AfkpN7bzsR/7JFLpnRpYi+d/cb1PIJLY3GHyh
	 MBH5LsH/Lzfd+LeqmNU8AltNw/bYfFNBtt2l2tdwqYTmwEJ0LUQviIEL85TuVwcSD3
	 IMsYVCZPvqM40y1b0nOdlDeeJZc21FPfsYORXiFvbLkRXG5T45nHZjowBSW7dDVu6R
	 ayQ8YXFRatRbA==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5a858881ad2so5078145e87.3
        for <linux-aspeed@lists.ozlabs.org>; Mon, 11 May 2026 13:05:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+iwK+EGgfYzBBqzeSsdu04W5Bu4W1C3hiYfQM9RHHatwuWoaPXmP1xHzu7CDwt63vnxiF0hkZDOzuq77s=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyQv3RYY6BdqumZld4gsjp6FVKTc63Jcz8xgkV6Bbo8n5Ta1rFz
	2b2yruSwi+4K6BoMxxp+oS0x0Dy7PiKuVgwCC1o4lik6PJE82GRI2NPmpGaPx85oiL80U6/TPdJ
	a7IIGqXTkM2UpIyQAw3G3/+yMIykJNx4=
X-Received: by 2002:a05:6512:4008:b0:5a8:80ce:ba55 with SMTP id
 2adb3069b0e04-5a887ae1e90mr8495895e87.11.1778529952053; Mon, 11 May 2026
 13:05:52 -0700 (PDT)
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
References: <20260506-upstream_pinctrl-v9-0-0636e22343ad@aspeedtech.com>
In-Reply-To: <20260506-upstream_pinctrl-v9-0-0636e22343ad@aspeedtech.com>
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 11 May 2026 22:05:40 +0200
X-Gmail-Original-Message-ID: <CAD++jLnJn9MOrsF0EPte26ZVbwVWHGuubqmTpss5D6Ep7kAY9A@mail.gmail.com>
X-Gm-Features: AVHnY4IWb6Oao5TaGJ75WC2JjZJs_EcccJqTLmElh9HpaEFa4BQJq1a2vLp7XN0
Message-ID: <CAD++jLnJn9MOrsF0EPte26ZVbwVWHGuubqmTpss5D6Ep7kAY9A@mail.gmail.com>
Subject: Re: [PATCH v9 0/3] pinctrl: aspeed: Add AST2700 SoC0 support
To: Billy Tsai <billy_tsai@aspeedtech.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
	Andrew Jeffery <andrew@codeconstruct.com.au>, Bartosz Golaszewski <brgl@kernel.org>, 
	Ryan Chen <ryan_chen@aspeedtech.com>, Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org, 
	linux-gpio@vger.kernel.org, linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 6, 2026 at 10:12=E2=80=AFAM Billy Tsai <billy_tsai@aspeedtech.c=
om> wrote:

> AST2700 is composed of two interconnected SoC instances, each providing
> its own pin control hardware. This series introduces bindings describing
> the AST2700 pinctrl architecture and adds pinctrl driver support for the
> SoC0 instance.
>
> The bindings document the AST2700 dual-SoC design and follow common
> pinctrl conventions, while the SoC0 driver implementation builds upon
> the existing ASPEED pinctrl infrastructure.

Patch applied!

Yours,
Linus Walleij

