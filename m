Return-Path: <linux-aspeed+bounces-3971-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DC1DFF887E
	for <linux-aspeed@archiver.kernel.org>; Tue, 28 Apr 2026 23:56:49 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g4y5X2tWLz2xYw;
	Wed, 29 Apr 2026 09:56:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777367543;
	cv=none; b=DtWeyKow4Fo7biJnwyJwGDAOyxvD/nARQySeIIkGVPwVIto9/fRpimPGTqHsgG+yYHwTMMuAc9bfVsJ/S3fN7wqDtCobs8wQzbQhUGuV7dLjuNURgZQjfrZbmQ+v7kHFoNI7WdAn9lYi3NuEfzlbzJ4C2rRdabQSJxGWn3QFMmeINCnbNj3OXKJlYZi5yNWl0t0exobsH4LE1OAM9r6UGZD4lRyf8mJIkw/M/ZeMUbBBKt9rP7BpwO2//cZG2UKK9lVvUhcJ9PFq3KbYxAgg7uRLf0Nqw0x3S24dDm2Ny8gVbcNovl/iw7OA9Lc5FNzEkNe0/YetWPjvp3/MmvVm5A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777367543; c=relaxed/relaxed;
	bh=uGpC8OFfJjEvHGP90N4kTx5472dBbjEkP4ZjjoHaizA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MJtl4jZ//ZTQgcRMOTMNJLsokmWJI+ZJzLnz4gahymL63PGtC6U5s4AEc4AoV8urA3OgjQGVsauHCYWAQuLYewtw26h3WSTUVD/v2xeGGUz3JH9b/RnA18N3NdWJ1HoUvUegctfWsscE9o3nGiP5AKuxsnIUJCNCmzfpBBtF5lWEHpvor/L4frXuLbrAaciwLQhDnSo0ZVohvOt7ih8ryuOhQGGqMJjX6iBRj9LFEunnndM0VHiH7DMvz1sHwKX9U/DqYJkmasstsjgMHFfjotB1z4fa93cNb+/opUWTVRwbT7HpRVgwSKFVw+VqqRT/0rT398tTlDe8so8zin3plQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=IRmGXFgS; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=linusw@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=IRmGXFgS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=linusw@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g4ZT317t5z2xcD
	for <linux-aspeed@lists.ozlabs.org>; Tue, 28 Apr 2026 19:12:23 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 5935544961
	for <linux-aspeed@lists.ozlabs.org>; Tue, 28 Apr 2026 09:12:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1831C2BCC7
	for <linux-aspeed@lists.ozlabs.org>; Tue, 28 Apr 2026 09:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777367533;
	bh=+vV1cq1FE3OBlSf+VVLa+jyUyRoJrEi+/2DabEYx9HY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=IRmGXFgSvCF3Yu7x4FvWQDcCfcF7Uwqf/IZmGl82fj2/WeDWxn/pgObJKt4DQMzpU
	 QKLOgAxg/wzYxmTWB5XpS5M4H6igwy0ANhBCnNK4qLQ6OY8lkfwQJ8JxHbnrBxeO6U
	 FhdgQs0Xf5cx9Hlwuzw0fMk8buKjpCL16Kkl3D7UIDZiLjMhpiTe1v7+WL4PxIRBaO
	 6RtJ9t1uUjUH0p8HzcPbX2Kr0KZEXjew3tzqcbGHR7UwG1KUzwDdS0hf31uPu53ccm
	 z1pgh2L+o1a/9G3lmV2sDmbXiwtSUkfU8Ofen7fKzYF/3/CSrS9AOGtfVQ9cYAdxKu
	 2KsFSmz+NLn8Q==
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-38dd575bca3so107587881fa.1
        for <linux-aspeed@lists.ozlabs.org>; Tue, 28 Apr 2026 02:12:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9HbfUK5GNHJLVdmxJPf7wMvRjCCLDjgMqm5RvRIIfRjTeWQ6P+6Wxi91fWI/jhzovIueyFZhUC5xtAkrg=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxaBnt6X1fDFPWcdt8t/Q6axOgOMSxulfyhZCEbxzMSlvKvTvuV
	tYZtFBIsjFpkU4XsmG2E4ujOQEYBnrDLl3917rJq8rqAukc307tLCu3HsvHPcIahp8Gr05DSgku
	P4QaYL3qSXUobdijJsjqvHyC9irzOQms=
X-Received: by 2002:a05:651c:f07:b0:38e:8357:c5ae with SMTP id
 38308e7fff4ca-39243147e32mr5888901fa.9.1777367532541; Tue, 28 Apr 2026
 02:12:12 -0700 (PDT)
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
References: <20260410-pinctrl-testing-v1-0-6f708c855867@oss.qualcomm.com> <20260410-pinctrl-testing-v1-4-6f708c855867@oss.qualcomm.com>
In-Reply-To: <20260410-pinctrl-testing-v1-4-6f708c855867@oss.qualcomm.com>
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 28 Apr 2026 11:12:00 +0200
X-Gmail-Original-Message-ID: <CAD++jL=Ee=BdLarnwFxM6A0+G9rYV4NJTm2go4p91ArZy-YLDA@mail.gmail.com>
X-Gm-Features: AVHnY4KEPMN0rWMtFgqCeeIxS-mVWtisiUNAOatuMw1puUfVBGi-Zw3AeUL_BJk
Message-ID: <CAD++jL=Ee=BdLarnwFxM6A0+G9rYV4NJTm2go4p91ArZy-YLDA@mail.gmail.com>
Subject: Re: [PATCH 4/4] ARM: realtek: MAINTAINERS: Include pin controller drivers
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Andrew Jeffery <andrew@codeconstruct.com.au>, linux-aspeed@lists.ozlabs.org, 
	openbmc@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, 
	Joel Stanley <joel@jms.id.au>, linux-realtek-soc@lists.infradead.org, 
	James Tai <james.tai@realtek.com>, Yu-Chun Lin <eleanor.lin@realtek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 10, 2026 at 3:05=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@oss.qualcomm.com> wrote:

> No dedicated maintainers are shown for Realtek SoC pin controllers,
> except pinctrl subsystem maintainer, which means reduced review and
> impression of abandoned drivers.  Pin controller drivers are essential
> part of an SoC, so in case of lack of dedicated entry at least cover it
> by the SoC platform maintainers.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

I didn't apply this patch since Yu-Chun says it will be applied to
the SoC tree.

Yours,
Linus Walleij

