Return-Path: <linux-aspeed+bounces-3443-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21DF9D61020
	for <linux-aspeed@archiver.kernel.org>; Thu, 29 Jan 2026 15:16:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f22mj2krnz2ydj;
	Fri, 30 Jan 2026 02:16:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1769699813;
	cv=none; b=cEic92uiRabAl6PCS5JCX5AaJP89VPDxIuueQUNn2g45Ow9LkM+uunW3hdnLcBfgf12540KE9PKKLP+g7nqEAYtMz+tjvR/7OrMxTtrsXjcGTtsWBnaftgGS1pyIq5AT2Uoa4NLZtlk/tsKXgbCaeM5AUkuo4jSRP6ECfSYBirDcCkHNs1jz3nKbZmTZeTntANuuorz3A0w3sn3hB3WquiGNMvf9QA+qj5IWWg6Ly6dSHuoN11YQtnOhItjRJCHqKp2ws3UezPIDBpqoWyRsETShZ6SlMn2b8vkSiGn7GH9dehT02DM89Tn2AqCYkr4icbo7l6eCIOJwtBBGfh8lJw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1769699813; c=relaxed/relaxed;
	bh=EgmtN7g00lwkN8JUHcOpWKDzOGBTid2ChoeKvuJnR2k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Oj5DO+jZ33bGaTatCxUR6PZQ+pBzqNRmc/wy/3NZRj/YNiWgDRM5WOY+ON66VCCQm8dWAqsSwgEPQjqcG0nIh/Ngy6n6PzEgcciMAevpT51ry7PXvgl2S8MmMWWJWYg/uULnPG0ZXclgOg57+UKYD8mL4fgYNOlHcVu2+3mFhNQrXtiBWzk8hUUttSp4KTpXfOeD8SbNzwuVUjN5ZAPzWH3ToKeJrWdapcqBGuHwQUBQx12gFmZxrSr6M1Gwx/NGzz9OmzTxDIQN0sAS+lYKr9NtMWrMqFRZgR1A2l6bTCf/lO9Rx2Nc02AhrFoGlWNATVzPfmGn/diJOTUQp137rg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=kiS3Pm5I; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=kiS3Pm5I;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f22mh3qChz2xQs
	for <linux-aspeed@lists.ozlabs.org>; Fri, 30 Jan 2026 02:16:52 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 82CD54420A
	for <linux-aspeed@lists.ozlabs.org>; Thu, 29 Jan 2026 15:16:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63639C2BC86
	for <linux-aspeed@lists.ozlabs.org>; Thu, 29 Jan 2026 15:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769699809;
	bh=O1tloW8gfVEMEcBPVggd9EMmWqLpPlFRfEzQCkil1HA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=kiS3Pm5IueYJq5TmZqGrS7X7C+cWyG1KdjBU9oiug7eGGcyzr2O934EguWjN3FDjz
	 gat2aSyrK4fKp5K+S6alGJQvo4aL5TDXGkyr1lEbH+drcNwr3BcQLLDTaNNvLcf0Xi
	 Xww/zptlAVq99/UpW7eL3bzwdZjWV+ansPM7JM9JvgnyVm3cmmydMgusNtXysqT+t5
	 i6bfvNdLW5qgYE0+CTzveGSBq6R2JV+1s8L8e1CvVBVR6xtcoFOP/+ee1u8/s4xTaU
	 DCPzLxwKeW7M0TJja1ZFpyoUC/GEnxOwm9VoOjHuipk19xaZAmreQTZDvMVfbO7DbG
	 FOXOUIoDAUB9w==
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b8707005183so166221166b.0
        for <linux-aspeed@lists.ozlabs.org>; Thu, 29 Jan 2026 07:16:49 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWPrrn8t1lkeNkOMGpireuH/VSmtJhXmMwSandpn22xpPH6WfaGUBTl41s5uCltIXKePFAth0t1TxO6AKk=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yzr8s4m00PERNxZ9gEm6pRPGXqGcgC2VnwvZ/xhxLTCSYD761fy
	qstjyBMmTC9lL47HPBKLvTdd3SVVaVKKPb92M+qm+VQHg60IbMR/E4Eza84bP5wZXwhnT9GJK9z
	dQ1aL8grvZ0hjdXUAFHYJk9RekiKLBg==
X-Received: by 2002:a17:907:940a:b0:b87:65c5:603a with SMTP id
 a640c23a62f3a-b8dab423ef5mr644045466b.39.1769699807795; Thu, 29 Jan 2026
 07:16:47 -0800 (PST)
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
References: <20251211-dev-dt-warnings-all-v1-0-21b18b9ada77@codeconstruct.com.au>
 <20251211-dev-dt-warnings-all-v1-5-21b18b9ada77@codeconstruct.com.au>
In-Reply-To: <20251211-dev-dt-warnings-all-v1-5-21b18b9ada77@codeconstruct.com.au>
From: Rob Herring <robh@kernel.org>
Date: Thu, 29 Jan 2026 09:16:35 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJxfVaLqzTwm7iEvc4maBzVvpc-i5uD6CZRtiv+V+7+1Q@mail.gmail.com>
X-Gm-Features: AZwV_QgoP-01T8gPVg_GjRssieKZeDUA4_1M3p-JswAzI-a2M9jAVmrm9uPisdk
Message-ID: <CAL_JsqJxfVaLqzTwm7iEvc4maBzVvpc-i5uD6CZRtiv+V+7+1Q@mail.gmail.com>
Subject: Re: [PATCH RFC 05/16] ARM: dts: aspeed: Remove unspecified LPC host
 controller node
To: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Linus Walleij <linusw@kernel.org>, Joel Stanley <joel@jms.id.au>, linux-hwmon@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	openbmc@lists.ozlabs.org, linux-gpio@vger.kernel.org, 
	linux-mmc@vger.kernel.org, linux-crypto@vger.kernel.org, 
	linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 11, 2025 at 2:46=E2=80=AFAM Andrew Jeffery
<andrew@codeconstruct.com.au> wrote:
>
> For the AST2500 the node was used for pinctrl purposes, and while the
> hardware capability is also present in the AST2400 and AST2600, the
> their pinctrl no relationship to it. Further, there's no corresponding
> binding, remove the node for now to
> eliminate the warnings.

Odd line break.

>
> Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>
> ---
>  arch/arm/boot/dts/aspeed/aspeed-g4.dtsi | 5 -----
>  arch/arm/boot/dts/aspeed/aspeed-g5.dtsi | 6 ------
>  arch/arm/boot/dts/aspeed/aspeed-g6.dtsi | 5 -----
>  3 files changed, 16 deletions(-)

Acked-by: Rob Herring (Arm) <robh@kernel.org>

