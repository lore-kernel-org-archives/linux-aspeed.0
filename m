Return-Path: <linux-aspeed+bounces-3474-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87C62E7FDCF
	for <linux-aspeed@archiver.kernel.org>; Wed,  4 Feb 2026 05:37:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f5TdM03wrz2xHt;
	Wed, 04 Feb 2026 16:37:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770183446;
	cv=none; b=HRtYrmiHy4JPKOy8SXg78m5/nY8PvpdMWYrOPFGsj+6u4KGz3dDG3NwB37q8+Q6s+SIw8V94Cnn8WjZdkDhq5W3kRYzXIDaM1HFOGt3gzysKUnw9UjGuouy+F9V245TL1lcwjnTaMWPKYoA8xBJJxnlgqZbMHVww5vTkSU8T51Xa/Hp3f3Tlt5h5peB5Irh4g6gCg1wrRytHZFgWXQJsn/Prx0dDZrNxMNn6pAtRYMZrr8v0ZL9fO33WaLvww5xXZqt1MN9eqFPAJvgS3HqBB5CMTNmuBoUB3tG8/ZwBDUJ4Kq8WhataxVFDphUDtZlgJvPGjkREd05mqTsfl0/R4g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770183446; c=relaxed/relaxed;
	bh=DdUNyXOvujvhPt+hXHM1uvHJZ3UgKsPIS+vRCXku+ig=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:To:
	 Date:Message-ID; b=gUleQXTCvw0CR8NSo8cyo4uwiUv0uIJknlHTrFE3jDVQLYcDpfOQDBaqzbZEgYaNSZpc9yaPnz3so+EdgpQT06A7nZRMr9YFrTEK9UWrQoMgqOnhzjrfcmX6yB8xr7OzBkvK3Iod69hQTYTmr9y5Jh0Gi5EuIxH3TMAMwGNEwAc0jq57X+yhtBWo8Rbr66TljkZ43+nUvaYq6npDBrWMz1qFaSl9dXncFwO7JhwfM80cpE2nG3uWFwbw/IIpUleZnITUk99hnfAsHJzh10hyLsaxWXqL+E8YuTaG95WvdQJ8t3i18L4Ir+Ms+bAfb6jOyrJyElDI33863xqzof9Zbg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=fxsq36n5; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=sboyd@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=fxsq36n5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=sboyd@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f5TdK5Swdz2xBV
	for <linux-aspeed@lists.ozlabs.org>; Wed, 04 Feb 2026 16:37:25 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 44C36409FC;
	Wed,  4 Feb 2026 05:37:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ABFDC4CEF7;
	Wed,  4 Feb 2026 05:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770183443;
	bh=DdUNyXOvujvhPt+hXHM1uvHJZ3UgKsPIS+vRCXku+ig=;
	h=In-Reply-To:References:Subject:From:To:Date:From;
	b=fxsq36n5ccJTll8D2V0Z1aqU012l7/JwvLvNMdXjDncIAAJmX0c63uLJ0FZYN3Yo0
	 +1CnSRlBLRuOX7xqgsmeN3zEjP9G8KdIzuWXhbnazgqYW5fwKr1+k7NcDRcQ6Brp2G
	 shMYb2y5roWPQdmBQMg8jttozAnyMQ3EvJZbYH0pzRQ5VMtMReZKnqluivJ2Or1A9b
	 1bHovcbErXdOwzoSIv5Snct+ryaf920nis7CSGgFkcEivv1aw0vw0eFGqMTMaYml0j
	 XnkRutUDdS3rrhCS4sbOU9IplV6bNXYufT+A7CbaodtvgjhN70UbfAclUiAuqK7O3S
	 rCPAOtCNBnxzw==
Content-Type: text/plain; charset="utf-8"
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
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20251003015845.2715538-3-jammy_huang@aspeedtech.com>
References: <20251003015845.2715538-1-jammy_huang@aspeedtech.com> <20251003015845.2715538-3-jammy_huang@aspeedtech.com>
Subject: Re: [PATCH v2 2/2] clk: aspeed: Add reset for HACE/VIDEO
From: Stephen Boyd <sboyd@kernel.org>
To: Jammy Huang <jammy_huang@aspeedtech.com>, andrew@codeconstruct.com.au, conor+dt@kernel.org, devicetree@vger.kernel.org, joel@jms.id.au, krzk+dt@kernel.org, linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, mturquette@baylibre.com, robh@kernel.org
Date: Tue, 03 Feb 2026 21:37:21 -0800
Message-ID: <177018344119.4027.5055693146328954429@lazor>
User-Agent: alot/0.11

Quoting Jammy Huang (2025-10-02 18:58:45)
> Add mappings of reset per hw's definition.
>=20
> Signed-off-by: Jammy Huang <jammy_huang@aspeedtech.com>
> ---

Applied to clk-next

