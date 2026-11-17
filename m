Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A42606A32A
	for <linux-aspeed@archiver.kernel.org>; Tue, 17 Nov 2026 22:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XJXcCEro
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jTfhW2x7Qz2xqL;
	Wed, 18 Nov 2026 09:35:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794924060;
	cv=none; b=EFNMHLZJEabHcjYsargsgjsTdAJnMXVzIoDgWid6vAq08Aw+LYGdPod06kaU4v/plClzTPqgpC8P0/1z2iaP6n6qAIplQNQ860iuQ5VW337iKqCswBz62VwdIGS+QOmxGaWAsjUMd7o0wqiJIoc5YKMA/mWUBi2lGCg+cUS3W8N4B8cISCxj2S2A1dLqCKQN8DuKqscRPE+RERqp9UKLE0TYKjqXoGbJ9kY9YQ/6H6DGLJ8jEXHCo05ltUwUPKcWrhVoSdpMqUFakly30kc3qkoyPDpdmXl712+n1p8F4fWA7DCtNYo/I5phHANatUxMIs984bDjThNmv2tmBSKrBg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794924060; c=relaxed/relaxed;
	bh=1n4akinMU4Hf+AOUS7LX8ylkG85tkNf4WcZP+gMfH/E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E6YeykkGwrRwjbpbCXgNqIMNDKFop3xGtHr+cIsVFnLiK4zNKAKq+ZdkHlfW1GQHXUJ/AyjZGBvdvErzjqBZ1kGrPvdt1PqgAuTQtF8y7QLwyc+Hg1s3oESsqvssVZz0NIXI9p//zy3c2FELZiIqLIJyLxBtQVDDQwx3qxkkyx5IdT+BbyVTRmwEaGxZOgNzm9fdKqrhLqkxAQLkKUxhNnpjVIzRkxK1XhkADI5VpHEfNt7659UB/ma2ZGmMLg8jrnstB18OsGFbrlfVzVUwxlymPh1/bcjLvnXZqqqG0vF3iiotW52wZbCzEGYx6T8gUbkXwyIrV1lBN08AtClVlA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XJXcCEro; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=linusw@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XJXcCEro;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=linusw@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jTRGN1L00z2xl0
	for <linux-aspeed@lists.ozlabs.org>; Wed, 18 Nov 2026 01:01:00 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 386F6634FB
	for <linux-aspeed@lists.ozlabs.org>; Tue, 17 Nov 2026 14:00:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3D671F000C9
	for <linux-aspeed@lists.ozlabs.org>; Tue, 17 Nov 2026 14:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794924056;
	bh=1n4akinMU4Hf+AOUS7LX8ylkG85tkNf4WcZP+gMfH/E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=XJXcCEroAaV7bIV2RBbIv9cQ8IK7q7IczrpxrkMMo/2FTVWOiZZngfZJShFb+Krxu
	 CeuvkYFMof6Q5FXfWeasA7J6Q5yM3v0nSXzDbZHS3xdC+2DD3Vh6HIy1yVcDw6mai7
	 Tx337CPuzb4SDQISkZELEhbK2WHPEvyW+TGUDr1jiu+bh05gUiXgXigMus/G/ZZ5Tg
	 JioMC1f7LPYYfexBdKBqxART6byY2phKj/ze27ao18Pd4JLyjdxtJi2c7+grzi9myY
	 dSkeA6OJaViGjZITJE0/UzjONOl4ndx9Oj5ol5W9DKsrfjJg/XCcl4BK7tBQ0tpTyr
	 L2W1048ZY0WoA==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5c07c7306e1so4915803e87.1
        for <linux-aspeed@lists.ozlabs.org>; Tue, 17 Nov 2026 06:00:56 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErEBBTt2Xb3gjRFOaoy69eetDgq5+TeJv8ulXktrHmKLCMZ2XBK0sYKabppkES//VHg5qzwlB1rsr8/0n6o=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z9ELOYlOiTfDrAuGGEMjgJ5IzxYnfuc9KxGaOYMGdRAsqAEV1dp
	QCqKXYpxZqIjWda04LEw728djO23nX5/4JJW2FYChXOFMxQOE3Q+nAZ/OKsXl+Bbbryhxf9VYCO
	z5UH+NhOO0R3lXru0xUx4OrHMaMc6exc=
X-Received: by 2002:a05:6512:3a96:b0:5c1:4e4c:359c with SMTP id
 2adb3069b0e04-5c1709c44cemr4959950e87.36.1794924055639; Tue, 17 Nov 2026
 06:00:55 -0800 (PST)
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
References: <20261107012236.28069-1-prasanth.padarthi10@gmail.com> <20261109035633.93522-1-prasanth.padarthi10@gmail.com>
In-Reply-To: <20261109035633.93522-1-prasanth.padarthi10@gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 17 Nov 2026 15:00:43 +0100
X-Gmail-Original-Message-ID: <CAD++jLmNSdgJPG_8dVKBLxN2ewvYJm99S+32SyKj_psa0DX53Q@mail.gmail.com>
X-Gm-Features: Aa3M54pM4N8FrMarps7ie1VxRtJp-XfzSOJDJp1i6ICkP2NWqZ4utwFMO5THjsE
Message-ID: <CAD++jLmNSdgJPG_8dVKBLxN2ewvYJm99S+32SyKj_psa0DX53Q@mail.gmail.com>
Subject: Re: [PATCH v2] pinctrl: aspeed: Use managed pinctrl registration
To: Prasanth Kumar Padarthi <prasanth.padarthi10@gmail.com>
Cc: andrew@codeconstruct.com.au, joel@jms.id.au, ryan_chen@aspeedtech.com, 
	billy_tsai@aspeedtech.com, linux-aspeed@lists.ozlabs.org, 
	openbmc@lists.ozlabs.org, linux-gpio@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 9, 2026 at 4:57=E2=80=AFAM Prasanth Kumar Padarthi
<prasanth.padarthi10@gmail.com> wrote:

> The shared Aspeed probe helper registers its controller with
> pinctrl_register(), but does not unregister it on device unbind.
> The registration can therefore outlive device-managed data.
>
> Use devm_pinctrl_register() to ensure the controller is unregistered
> during device teardown.
>
> Fixes: 4d3d0e4272d8 ("pinctrl: Add core support for Aspeed SoCs")
> Signed-off-by: Prasanth Kumar Padarthi <prasanth.padarthi10@gmail.com>
> Reviewed-by: Andrew Jeffery <andrew@codeconstruct.com.au>
> ---
> Changes in v2:
> - Add Fixes trailer.
> - Add Reviewed-by trailer from Andrew Jeffery.

Patch applied as nonurgent fix.

Yours,
Linus Walleij

