Return-Path: <linux-aspeed+bounces-4115-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E453CD4F5B
	for <linux-aspeed@archiver.kernel.org>; Fri, 22 May 2026 03:49:44 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gMB9f6B90z2xpn;
	Fri, 22 May 2026 13:49:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::1233" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779421782;
	cv=pass; b=Hzz2mg45bJRmeY3HTuKtvIXQ86cB5mIgqnZZb4q2Z4VbhRx+OQXicrI6qA5PmrjcZTEyWG/mGC+pdAb4dNYmK/8aqLe2bQkE4s4iYhP7HF1b2j5rJZLHArxv6DTx39tNqAf3nJ7SUYpO5kwLKZWdzZOzm4RjpkL3gT6wR1aEGcp7OVB9B5XN2IfekQj+Xm+d8h+7RtkvPEtoyxklIpiLFXdXvXTBhTnz/ul+BTMW2h5zrrgVvMnG9ev8eFTMZlyERLZ921751pzuqQVdJfokpJKktUBP4Pj3FHWwsU0jc1x821nUxyX0oa0LV+h2TYk+G7zVZpi61hCPe9d5tRLzQA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779421782; c=relaxed/relaxed;
	bh=+qT5BbvAf0970jGpHLlqJ9wvkmx5X5Z5+OFS5PTjFcE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jh3uMtG7YggmHEB6nfEGnEoyh2xon5Dku2L9D4RNXWNzbP9OZNZSbnVusNW5viF2v9ka2M9FAdGep2Rub7svFYzMDWoZXE1L2KiFmAdSNvRD5KZfRfYIXw85yq6WoeC+bAvI+qQeBFL63Sm6JgH9f/yK1FyjtFw6AfHZtzZRYhtHCsWFwPXCUyWZbqTr9tMnM8EyxgIsoAvDEizGoQQTE3e8mlWOPqGHK5q6dUEfEu2Th0mx9ebHMa1V2u54yf7dj1YKvBH5ttn5xsE3zZ+Z70GggLe5K1RZkIm7m/EwKaT4hvDLcrCvhiXMBuKBGB8Q6t/HZZpQwV1DIKlcxu7ECA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=WdGTjB83; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1233; helo=mail-dl1-x1233.google.com; envelope-from=anirudhsriniv@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=WdGTjB83;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1233; helo=mail-dl1-x1233.google.com; envelope-from=anirudhsriniv@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dl1-x1233.google.com (mail-dl1-x1233.google.com [IPv6:2607:f8b0:4864:20::1233])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gMB9d2scTz2xSN
	for <linux-aspeed@lists.ozlabs.org>; Fri, 22 May 2026 13:49:40 +1000 (AEST)
Received: by mail-dl1-x1233.google.com with SMTP id a92af1059eb24-1357c851a48so8489170c88.1
        for <linux-aspeed@lists.ozlabs.org>; Thu, 21 May 2026 20:49:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779421777; cv=none;
        d=google.com; s=arc-20240605;
        b=Ks0/XR6OtAGiVtrGBJBRvHle1hx0EwBcVRI9Yyc99rqO+BEqFUbEJDhNLpCYfQpRLJ
         4u4nClRGMRehFU0sEBO3WM1f6hrubmpAiQ04JwLUYgP9kNArtpscOMjGq0wKIrOKg0da
         kkjqlgizqZFYSk/16OowtiG9nUi1SwS7NFsCNzeBBWxiEhjoH9N46VU4XcDmHr1UCkH3
         V38swtrMPVgejCmbpz3z67kgu//T7YJ2LpGE/05UehtQvM3uvU/dS4rpCmZEWIUER64E
         4Id62beztPs1ZPuwI5nKVkkDtJfdizJJdelaLbWtMtZsqj9x6gbrJsvS2sO1c7LwpK6F
         du0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+qT5BbvAf0970jGpHLlqJ9wvkmx5X5Z5+OFS5PTjFcE=;
        fh=m1NEvMXQxgp80CaVez9158w0XsxuSk2WlfXWoc+LjOQ=;
        b=UtyXK/wMvDBNTzacrf2w2CwqFPtXj+Nh94l0Mc3LGQKODW7EDA7d+yGKzE8Gmg0m2J
         yDVvtq2vJA3XhfQxa0Ypi1woYA/evVM8XwEArDhQba+WIQKIWF8SkeFfWes698Gc4qHK
         X2qWOjHVgIL/8HLhxuIOM1BL+EmlpjNIjs5ksurXGVrYboKItL5umn1erfI6wEAYRC+w
         GzNddsSwKJOm36t4yvdCR8hHzQN/J1pZ1jk5PoRJ7sbALCjHFcBnFogH8uyAclQLlb36
         E2ut5OG3xg5SiT+jr1VuTXLeCu4O5SBRL4P+ZH9NYnGNP7XLqcQBGky+cShmGVxYyZvD
         kWXA==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779421777; x=1780026577; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+qT5BbvAf0970jGpHLlqJ9wvkmx5X5Z5+OFS5PTjFcE=;
        b=WdGTjB83fDnA/CZKx6Atx0b5j9AoODMopHmIjnT+njlPuw4pOHztEWauX9j7uweEls
         Fr6mAyKhNl+ZAeYAhQzXq6Ej6xDcdt85H1lwh2FUMBvv+YLFUXkzT8EcMJWYkjc9Y5FG
         X4YC1GRsuqdf+TkW7QfdnktPeULEN8YkbQ6W7sW4GncmShrEEkrrrKg1GjooN1bLNyuL
         9Ghg6JB9eXKnzd2saEgCRc0CI+e0JhOR2GwgRGteY0dtvrXzP2xYqUhtceNPmojh+v2U
         VfZ/pR52qhZUjOzIcAF5caQiZE4+U3Rv3SSuYrkQkUSgY2al59G+qcRjAXDrHR6iMEwU
         zK5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779421777; x=1780026577;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+qT5BbvAf0970jGpHLlqJ9wvkmx5X5Z5+OFS5PTjFcE=;
        b=cZ7xzCeA0VgMJ2tjMewgNiRfC8Xeg5Mwkep/8Ti2LWX3s92/Sxj81FvpCXW/S2KX6G
         hcGhED8pWITBBz441Vfungqh//IJWKf1bgSBHo96bEs5ZZms+D9NXLoT2k7a5iZDz0wh
         xW0vA2SHfVEIiGs/5CKbWH8hSxI4TsFd7WRHEDYtVDTQbOYPQT93zsIIHDdi4BBuNcw8
         tf8s4+LD3SzZA36g2FRAge4EdcuMNbF2vCVU8aCYMQ4MbakthFWH8szHR1bX11ZsmH8O
         zNvonjgqMItj3MUWUdpduryqflJVDp9vCnq9FQXCuHx+1qoa2WXmE67ncchss0oocNN3
         eH0g==
X-Forwarded-Encrypted: i=1; AFNElJ+fkVI2ePqMhOOkE2v23TG7p4vMlFmcXAbDWGbIONQ0wcTgg9j3KNiUXn+4+1TrCsikPnGXqUwKU8f0W18=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzA9NxvJYS62t0BFHDFbMDdpKgwT9zQqixX0WiZSbO9rvdDfDHR
	8x3W2O+Su6H5nWqwTDmdA0wIveuSUb1yIpyGZWwdSgkyYbg8nhg3llxN4UhagGvL5ZcG9uMTVwI
	QxHGMth15wQNNiY7GuEzbZYimyS1q3IM=
X-Gm-Gg: Acq92OHzutA2EWLRVEPlrRTEHY72trqUsxWmZFuBHo84t7IXelmtuRNydVl73lY2k5/
	S5zKG/xN6uH1dLIXHCCBbmr/gW2AhkHW9OGBrgAJyisHtbC9A7Pk51agXunDPBsQQ5zDuayIwTq
	KHpaogUahfDch0jEYyR58+KJfisSMFV2q4Bo0xx7gtqE4Hk/b4TJlb1oItQQFkMSZ60o4ylKx/n
	xq874Dh+cp4Z2QQXQX6YwY8/kZ+kHSLBarHapYQFpt+XZHAyG/lEFgLTELP/q8vDCupSgw5C4Wz
	e2bMeMlVPpdM5ebeyNm+QKubcyVQuonNhjehpkEt
X-Received: by 2002:a05:7022:4a4:b0:135:2640:70cc with SMTP id
 a92af1059eb24-1365f6fe0d9mr845587c88.5.1779421777083; Thu, 21 May 2026
 20:49:37 -0700 (PDT)
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
References: <20260331-asus-kommando-networking-v2-1-f7d72ae5d40d@gmail.com>
In-Reply-To: <20260331-asus-kommando-networking-v2-1-f7d72ae5d40d@gmail.com>
From: Anirudh Srinivasan <anirudhsriniv@gmail.com>
Date: Thu, 21 May 2026 22:49:24 -0500
X-Gm-Features: AVHnY4Ka54_MLKGXewXkQbTwbb4nAvWDr8M9psv1cc8wtCfvwYFbBij8bhm-Seo
Message-ID: <CAJ13v3RtV+_P_ShfrM5vH+neT0cB6t5yAbqGiiw7S7Y8qpVY=Q@mail.gmail.com>
Subject: Re: [PATCH v2] ARM: dts: aspeed: Enable networking for Asus Kommando
 IPMI Card
To: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Andrew Lunn <andrew@lunn.ch>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Joel Stanley <joel@jms.id.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On Tue, Mar 31, 2026 at 9:18=E2=80=AFAM Anirudh Srinivasan
<anirudhsriniv@gmail.com> wrote:
>
> Adds the DT nodes needed for ethernet support for Asus Kommando, with
> phy mode set to rgmii-id.
>
> When this DT was originally added, the phy mode was set to rgmii (which
> was incorrect). It was suggested to remove networking support from the
> DT till the Aspeed networking driver was patched so that the correct phy
> mode could be used.
>
> The discussion in [1] mentions that u-boot was inserting clk delays that
> weren't needed, which resulted in needing to set the phy mode in linux
> to rgmii incorrectly. The solution suggested there was to patch u-boot to
> no longer insert these clk delays and use rgmii-id as the phy mode for
> any future DTs added to linux.
>
> This DT was tested (on the OpenBMC u-boot fork [2]) with a u-boot DT
> modified to insert clk delays of 0 (instead of patching u-boot itself).
> [3] adds a u-boot DT for this device (without networking) and describes
> how to patch it to add networking support. If this patched DT is used,
> then networking works with rgmii-id phy mode in both u-boot and linux.
>
> [1] https://lore.kernel.org/linux-aspeed/ef88bb50-9f2c-458d-a7e5-dc5ecb9c=
777a@lunn.ch/
> [2] https://github.com/openbmc/u-boot/tree/v2019.04-aspeed-openbmc
> [3] https://lore.kernel.org/openbmc/20260328-asus-kommando-v2-1-2a656f8cd=
314@gmail.com/
>
> Signed-off-by: Anirudh Srinivasan <anirudhsriniv@gmail.com>
> ---
> This patch is based off aspeed/arm/dt from bmc tree
> ---
> Changes in v2:
> - Commit message now mentions that the u-boot tested against is the
>   openbmc u-boot fork
> - Link to v1: https://lore.kernel.org/r/20260328-asus-kommando-networking=
-v1-1-66d308b88536@gmail.com
> ---
>  .../dts/aspeed/aspeed-bmc-asus-kommando-ipmi-card.dts  | 18 ++++++++++++=
++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-asus-kommando-ipmi-card.=
dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-asus-kommando-ipmi-card.dts
> index ab7ad320067c1ddc0fea9ac386fd488c8ef28184..e0f7d92efa18ccbad2c336236=
c3b9d01b7de1bba 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-asus-kommando-ipmi-card.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-asus-kommando-ipmi-card.dts
> @@ -107,6 +107,24 @@ &gpio1 {
>         /*18E0 32*/ "","","","","","","","";
>  };
>
> +&mac2 {
> +       status =3D "okay";
> +
> +       phy-mode =3D "rgmii-id";
> +       phy-handle =3D <&ethphy2>;
> +       pinctrl-names =3D "default";
> +       pinctrl-0 =3D <&pinctrl_rgmii3_default>;
> +};
> +
> +&mdio2 {
> +       status =3D "okay";
> +
> +       ethphy2: ethernet-phy@0 {
> +               compatible =3D "ethernet-phy-ieee802.3-c22";
> +               reg =3D <0>;
> +       };
> +};
> +
>  &vhub {
>         status =3D "okay";
>  };
>
> ---
> base-commit: 76b4ec8efdc3887cdbf730da2e55881fc1a18770
> change-id: 20260328-asus-kommando-networking-5c0612aa6b8c
>
> Best regards,
> --
> Anirudh Srinivasan <anirudhsriniv@gmail.com>
>

While we're figuring out what to do with u-boot, what are your
thoughts on getting this patch in so that the kernel DTS changes
needed for networking land in this cycle?

The current commit message might become somewhat outdated if the
u-boot patch changes though, so not sure if that's okay.


--
Regards
Anirudh Srinivasan

