Return-Path: <linux-aspeed+bounces-1497-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F28F0C7115A
	for <linux-aspeed@archiver.kernel.org>; Wed, 18 Jun 2025 12:15:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bMjPT0Jg1z2xS0;
	Wed, 18 Jun 2025 22:15:41 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::12e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1750248941;
	cv=none; b=YPPmt7ruzifoDLXdhPwJiVfGtf28DwxgYKVsosFZPqnZzoGKPHAzfaynFKeeuiKv4KSgQ9KqPcQb6NDxOBITh9UA1RxMQgXkuMmv33jqgT6tDNwA1VN8jXcCx70KlQ/rd9L3wMcf3IyS3zskyVK5miem/0NlW1Rjeba2mMU9wpIpjzg+AwCuzrpWHvstdSlI73kQuhTYq7dVFQ/DBy7QSAVSTJSPq82vzzoFdsgAJBMF7Y6Ri9a3NMaV45Ie8xQKz3iuDx3mDXvltidA6Op/qkpa01HDwmyMOV7553rUVd4i1byl0nDJGKQaHyKvfz7vd2aR0q0NXOGThgpTk7ervg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1750248941; c=relaxed/relaxed;
	bh=p7jZQ+YS+lWYeVwEC8VFaNnmqDYcJYXkLsLKJpyV1y0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EK7EYadrbrZBI1t+ipd39gIMxPQ1jnZM3ovyHyjCxnnnuSQuFyBLLlq6yCX2E12qw9QkYxb5xrQ4lSXRN98hcMeNEEgSLgr7k2D1+vIO9RbpUqvXlxZbmbV8S+hALXnhZrbXaAoSMhNuosSscEUCWiQ9QzBOyd7UdGkZ629O9eGEYHAr8V+mFAAlbd5jcH1+fklHyHb5gbiB+jCXu1E5kN5VKH18mX0AYgbfEHMhxN07PNqkm6kf6ekKSlFD3CsIuwso7d3o5itgcgCxcXx1GebAr4j0ZpSJmDOt9/gKfWu9zSTWcYIXgfEFXMtRO91+F6oOJvSypWpB6ntQ0YNMiw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org; dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=qnSUknk5; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::12e; helo=mail-lf1-x12e.google.com; envelope-from=linus.walleij@linaro.org; receiver=lists.ozlabs.org) smtp.mailfrom=linaro.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=qnSUknk5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linaro.org (client-ip=2a00:1450:4864:20::12e; helo=mail-lf1-x12e.google.com; envelope-from=linus.walleij@linaro.org; receiver=lists.ozlabs.org)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bMjPQ6L0Kz2xPc
	for <linux-aspeed@lists.ozlabs.org>; Wed, 18 Jun 2025 22:15:37 +1000 (AEST)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-553d771435fso43128e87.3
        for <linux-aspeed@lists.ozlabs.org>; Wed, 18 Jun 2025 05:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750248935; x=1750853735; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p7jZQ+YS+lWYeVwEC8VFaNnmqDYcJYXkLsLKJpyV1y0=;
        b=qnSUknk57cpjhYgC+B2MsREjjPOTlfJ4DyT2CHbgYdSGnZx0b52Gsv0j5nZ1sQbxyo
         m3vOW1hn90kCQ9MYSNcNJdxutBAvKVZ8JiNFosLKCFUmq5hz3M1GwBvi4pnekP+BiJDt
         HCChMwa0ZJJqqZh9BRiEUNze3GIQhiuHXA0KOde7u8HtyOREFwW+M7W7jNzVXnNtkNUI
         fnSjOS7Og4dWGFuOk1KAiI66IKglqj5eUyZ5LpenobsIF8/9pOgXtT2euz+BItS4TmRt
         R0shj3U1dP3iJYHBSBZGj+1FUne8ywH1vEPVLvYmJMUPkmNljjalSSoXmpMwAy6wHDnv
         uEmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750248935; x=1750853735;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p7jZQ+YS+lWYeVwEC8VFaNnmqDYcJYXkLsLKJpyV1y0=;
        b=C/miduBypZxvmzBHWfBmGHTXwf5l4oiAUGj5+l5DekDtKvz+qJfPAcqKoAjk+RjL/s
         PEhd5Wa5onkGcfsfmDS/IYndBvUNeiMYAA3UOjRzReESI0ggc5unsVhU1MNa8gnRogxH
         s4+kq4+bwPN5vqbebg0JjjXZt2IsHafazhCcp/6HW9xfZT7CD9wnUcCkhhUbvnJfUiKR
         RwBw/6Pys+DkrlXQcnBc24icYoWtH4PFX3l9R7Lx0I3JZi2qxAaJJZshd/wu0AMOlg+P
         gi7Aov6wMLfmyzrpZ4wfetueS6hS5mm+5XjrjoZCiaoU0ai4pkZjOL0aM5Ce/wRTgXGO
         REKg==
X-Forwarded-Encrypted: i=1; AJvYcCUzWLb1fmwvMj0u9erRW5H1rapF9qEP/mB3iRkoi0RsLZpYpUBXlQJCf3v3yZ0/s6jwHC+lPQ19L6McInQ=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyJdFkKT/rx11v5PIU69z6EPBZe3TOsJ9EEDV7IvZoMIbA42hkn
	wtlOGFZniR88858AEy4qrXRAlRXPGLbsOIuABu04KYeF2/ZBd0/5W67PdecEOxTxqG73bYXpil5
	4R1ikzoe7iKItP2sJ4RFPvwyCTshH9UBpc21acHMGZA==
X-Gm-Gg: ASbGncs93aIwMkeboAfmRCI9X2fAUcjwbNk2xJnzRH6hvUoxvlpz6iYqiPJ566cX2Y7
	epjgLsDQxeEHY/nOUEALa6V+632Q1wtjrApWltPojNihpW0GtqiUC2Yy8Uq/Ki9ftANMUr+PeiE
	+fG6zkOPS63dNAF5B3yt6rGIK3ydMzCDvv/8+6bZYv+yo=
X-Google-Smtp-Source: AGHT+IGBMbnQS8CZK59QUADw6V+D/mLT8w6YMYDnxWivA5Amu6Cgv0XDSbL6jWX7zdVZfzp8QG5Ih8L/ToZVwFJNik0=
X-Received: by 2002:a05:6512:1285:b0:545:6fa:bf5f with SMTP id
 2adb3069b0e04-553b6e732b1mr4223465e87.2.1750248934811; Wed, 18 Jun 2025
 05:15:34 -0700 (PDT)
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
References: <20250613033001.3153637-1-jacky_chou@aspeedtech.com> <20250613033001.3153637-7-jacky_chou@aspeedtech.com>
In-Reply-To: <20250613033001.3153637-7-jacky_chou@aspeedtech.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 18 Jun 2025 14:15:23 +0200
X-Gm-Features: AX0GCFscY4ky5ebft20JokFvuO1y3hVcQ04FGalsWAeschf7cTa_SUmnKoC4ETU
Message-ID: <CACRpkdaX24z5YsfcrB2oqbZpdexZJNREGkWiYgq1ar0c8O0QBA@mail.gmail.com>
Subject: Re: [PATCH 6/7] pinctrl: aspeed-g6: Add PCIe RC PERST pin group
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org, 
	mani@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	joel@jms.id.au, andrew@codeconstruct.com.au, vkoul@kernel.org, 
	kishon@kernel.org, p.zabel@pengutronix.de, linux-aspeed@lists.ozlabs.org, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-phy@lists.infradead.org, openbmc@lists.ozlabs.org, 
	linux-gpio@vger.kernel.org, elbadrym@google.com, romlem@google.com, 
	anhphan@google.com, wak@google.com, yuxiaozhang@google.com, 
	BMC-SW@aspeedtech.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 13, 2025 at 5:30=E2=80=AFAM Jacky Chou <jacky_chou@aspeedtech.c=
om> wrote:

> The PCIe RC PERST uses SSPRST# as PERST#  and enable this pin
> to output.
>
> Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Can I just apply this patch 6/7 in isolation from the others, to
the pin control tree?

Yours,
Linus Walleij

