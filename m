Return-Path: <linux-aspeed+bounces-3391-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A91FAC9830C
	for <linux-aspeed@archiver.kernel.org>; Mon, 19 Jan 2026 00:18:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dvWJk0klzz305M;
	Mon, 19 Jan 2026 11:18:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768781554;
	cv=none; b=CbsAfySN6Az3F2ie8++Qej1ZgA/F9v0m0xTEjX82cnS9JnophKiFiT2XS/zaAeHVZHfWXHjl6NRVasTEfeBRArPI2BdDP6RRlhyHX1yfcVchcSvHEK10fV1bShrhBTGz5P/oLC4yDd0fPQALUCRdBbGBzHJzDIkjLk7vpACMQ+Rpw9uri4A4gA7ySGh18fraQm45MpzXRVPNtN1zu9bBtCJoYJUC1F762mBFkZVHzoxNeNNd6UwjKPVk7IRl/jXnooQW2y+UuNkHRs9+KVsLxeRY5+LzJWVc24jD/LOQ4oyeTte0VrgK1JIBglef7Qq26xlEVSa0+/UaVNajphPQbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768781554; c=relaxed/relaxed;
	bh=77e96+tn9mecLGBrZtPY9Ll7+CLmgZeo5o+F4wCK57E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WmgTZFQKUOvjnmmjvltK4KY+IDapdZzgmgNkrcie1xoAim+lWKJvKVBLjsn4WkOq7nCMxrH8eFcviw+1Y+VCsZPmlfAg51ynfWvNeF0E3vBnsfcBCwYeSGVnN5f+LSOrUBQRUoU5HBvqHqfYd4T9kvO4qei/oDNF3UuV0fNG4fiIIYW0qZe7TpDD2HK6P2aXg6uumbAHlElEmRzIp+EmuH6eMR6Ed7iVW0QlNFLP8/3IQuUYff7K7yZ9NG/JxKTaSYLV5JqmdvdyjFAjLfE9Xt/XvP3Ca7RcJ4NBuPJ/sPGqKyOZqTNJ4aLHPJ5cSY8if0c/npHgEQ1X65LF4jG+mg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=nW7h+1My; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=linusw@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=nW7h+1My;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=linusw@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dvW9s4PVVz2xS5
	for <linux-aspeed@lists.ozlabs.org>; Mon, 19 Jan 2026 11:12:33 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 3BE1843B42
	for <linux-aspeed@lists.ozlabs.org>; Mon, 19 Jan 2026 00:12:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C3E4C116D0
	for <linux-aspeed@lists.ozlabs.org>; Mon, 19 Jan 2026 00:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768781551;
	bh=GM6hjWxnbx0Rs5/7Y45dHtccDdEstdeBQZhCBY29WCk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=nW7h+1MyHv+XY/D+QMgQoPSEsvqC4xZS08EgMm5QgWJWAQqCzRkqWlAFfEeFeKwzk
	 uoviDMATdhhTN9GYHHY9iRFzkaxxUD9pLBAMVOYbGJeVRuCnSJApuxVhY8BCvxlQ5E
	 dgoArPak6gRs4bBLk5jVHbVkVkg4zsSs+2pVVD3EOiqYMmh34OZJEd/rJul6jkgQJ+
	 e9oaDFyyAJoQ1Qp1DeErXTf+NherfvJ7rOJgwo457Bfp0Mm6oQ9fii3A6VAYrU5mb5
	 JbGTWaIr7+xmJpWRxkx0Zf99/arNagUn4ATg1W9VXanBKldhTQJ3Mec8vROa2lsBl2
	 3o8700Mmbeq+g==
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-649295a4a5bso417297d50.2
        for <linux-aspeed@lists.ozlabs.org>; Sun, 18 Jan 2026 16:12:31 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXgAsRxFPSERupDr1OMB7haPJEn1v0vU3HP02MfwMPqS3Mq+J9/CDtxeq/hdkjo5Mq0NwOXYwLJFN9AgG4=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyT26Tjhc0F5SsDi4y/QV7wYEwBj25xUENxExjjGBecq3XTTcsi
	0e1CFVCysWfEzITjHM+3cJbCz6aN9zpL72ak4cC63vSKTxYBrQqEirUAbvxDjVxYYrBuylupp2d
	JCY+zUCHne+TjkFEHqnqYeQzg8Dn60cw=
X-Received: by 2002:a05:690c:f96:b0:788:989:fdae with SMTP id
 00721157ae682-793c52a3abdmr187836947b3.28.1768781550470; Sun, 18 Jan 2026
 16:12:30 -0800 (PST)
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
References: <20260118-pinctrl-cleanup-guard-v2-0-bd36f681bdc0@oss.qualcomm.com>
In-Reply-To: <20260118-pinctrl-cleanup-guard-v2-0-bd36f681bdc0@oss.qualcomm.com>
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 19 Jan 2026 01:12:19 +0100
X-Gmail-Original-Message-ID: <CAD++jL=+MP0UZsPRAh=+1TL+7ow+rZ_VqNW=XZN1Ht82Lw88FQ@mail.gmail.com>
X-Gm-Features: AZwV_QgFwFIzeGhMFaeDXLwmJd24DRy_tYYmpsNkgD6HAMBqdqwm-YSi6s6fPfs
Message-ID: <CAD++jL=+MP0UZsPRAh=+1TL+7ow+rZ_VqNW=XZN1Ht82Lw88FQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/11] pinctrl: Some code cleanup including guards
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, 
	Emil Renner Berthing <kernel@esmil.dk>, Hal Feng <hal.feng@starfivetech.com>, 
	Chen Wang <unicorn_wang@outlook.com>, Inochi Amaoto <inochiama@gmail.com>, 
	Basavaraj Natikar <Basavaraj.Natikar@amd.com>, Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, 
	Bartosz Golaszewski <brgl@kernel.org>, Steen Hegelund <Steen.Hegelund@microchip.com>, 
	Daniel Machon <daniel.machon@microchip.com>, UNGLinuxDriver@microchip.com, 
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Heiko Stuebner <heiko@sntech.de>, Patrice Chotard <patrice.chotard@foss.st.com>, 
	linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org, 
	linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, sophgo@lists.linux.dev, 
	linux-tegra@vger.kernel.org, linux-rockchip@lists.infradead.org, 
	Thierry Reding <treding@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 18, 2026 at 7:10=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@oss.qualcomm.com> wrote:

> Changes in v2:
> - Patch #9 (pinctrl: tegra-xusb) - Drop stale mutex_unlock (Jon)
> - Add tags
> - Link to v1: https://patch.msgid.link/20260114-pinctrl-cleanup-guard-v1-=
0-a14572685cd3@oss.qualcomm.com
>
> Few cleanups - from unused headers - or code simplifyings, including
> usage of guards when beneficial.  I did not conver cases where guards
> would be mixed with gotos, because this is discouraged practice.

v2 looks good so patches applied!

Yours,
Linus Walleij

