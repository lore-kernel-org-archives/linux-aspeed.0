Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85751606A320
	for <linux-aspeed@archiver.kernel.org>; Tue, 10 Nov 2026 23:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qVXWsx2f
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jPMbj72CCz2yR1;
	Wed, 11 Nov 2026 10:01:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::630" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794286172;
	cv=pass; b=XZeD75uNGhyGyEgMu7LJuH8YgfOOQPXPIYYMIjzKiQd17GGZTUCtVicyPRvw/JOy/RMLe8areGz5V7IpOjrOoQe4dq3xef2WFENH+Z5reZvHiDUqm/SBH8kmLshvfublx6gui0uJv2z9N8LdSGl31ITneH63Z1XEYD7i38No25U/xMuiPMVHxqnlDlIjAMKB+5OpIB4w6wexWVYUGjiWhSX+t8I/BLOS8PN35E7sAhcAoZCzT54ZBeFEOBQU80bMQzJeh7jsvjJdR36urv//UUUNMV1IjDFYA9JtOecfAubmk6X3NsvByT0TR/PPzRuWO7tZSEIc0rnQhZ5pijCi7g==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794286172; c=relaxed/relaxed;
	bh=ToRZM5Foy++C1k59kSDpzw5FEF6siS+FDf6LC+WQ3Lg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NIYqB/Zjq6AN89psvsGW5gU0vVBq+pmwMgS14w7xjhRWVbXyDbF4pcd2dnKhKofAvPyiaSdmIlae/OI/CfpWfBKsei+QASOeTYICVwde72YA3zJXgjicmFvgDXziKvGB/WVgoK15wQmWGSKQw3Dj1JaydMwEoh8Egse1scrUH/zAHGx508DpxF3O+BSO1vicBur9/+Wg7uf6pCzvjthc8bdrEoOoH/j2IX3JtPokKTmMHsMlfJCWxDTTfZpidPYge3ErBJ8HO6FiwT6oO1UWMFl5bBulOWRqeZju6V1TtvdnqXiQp+omkBfKj6PjHpL/K/Oiu/zA1COoyxVDx7V2Tg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qVXWsx2f; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::630; helo=mail-ej1-x630.google.com; envelope-from=mhun512@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qVXWsx2f;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::630; helo=mail-ej1-x630.google.com; envelope-from=mhun512@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jNvMG4F2hz2xf8
	for <linux-aspeed@lists.ozlabs.org>; Tue, 10 Nov 2026 15:49:29 +1100 (AEDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-c434376dbebso302190866b.1
        for <linux-aspeed@lists.ozlabs.org>; Mon, 09 Nov 2026 20:49:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794286165; cv=none;
        d=google.com; s=arc-20260327;
        b=M85owAbgJADjZIfymhPdIjKHqWiQj0c156RyyJ4Xkh2krhy7l2ZqgkDdhbyuaiU5XX
         fG6ZzhFE2ke9Eb4zJaxL4iP71zdHCf05knKjRNFM7mi+Dn2jQgX4OKWQUSQagCMuB5tV
         de841lKXdIT6Io+nv0jCQAj8fjxA8/8QbjcoNdSnOyggDozsqbbkZtFBiPjSsSZxzopu
         G6EflcakdPrWsrlMlNk8+DR2FUCtXKutY773IrjAS8/LnjpbtIE8Go68wlqfRyMnmQLh
         3UGnDLlCIKvmwyWOhQsctg2N7iFzti11BN8kJColUuFGWqMrqrtI9qhszLTpSQeGbtmd
         f01w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ToRZM5Foy++C1k59kSDpzw5FEF6siS+FDf6LC+WQ3Lg=;
        fh=VVM+F/N5vck872rUQEqWBDRnuEcOmb8HPGqBY0lcFVA=;
        b=asoHdVofjk8enDMBUeDZf/gu2i8+UfZ61gGnwyhrCCGYT0aHHYP3ajT1C5gpV7Nq9T
         6Tj6HiaLTMDkrTLXiWffK7a1GnHpTRqo0V0KvugG8P+SR4CppFcnu0Vlo6MlQ+qD5k+C
         TtJb2w8CNh2dCLISz+P0Q5RH3VWDTt9wnlwr9mmyFcvcQg78jPQaukiPHeZe4SrZmyzV
         sbNAUwHCkelIG4PsiKgTy8ALrw3e6kHxFaa6VN6J1XUvpnT6XG/rOIbulDGdXg+aK1lR
         WNqiNOC6+3/3hL8sKVzkRys+W5Hl1VRmQZQQdh5MeM6hcw+VfaTB6/rjmP5UIItWoIHP
         EtoQ==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794286165; x=1794890965; darn=lists.ozlabs.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ToRZM5Foy++C1k59kSDpzw5FEF6siS+FDf6LC+WQ3Lg=;
        b=qVXWsx2f9Zkj9TQevZdznxoTAiT+qZQjccpZhnHs/YNFOiwtg7APiFxq/XVoFiKcRL
         syL6Yx1BKzMDR7k6AUbkI8gH6jHhpbU7ljUxgjJsUTljizjOOIGmw2Xz/1M/AnRVAiKS
         SWrtn/2XRWspKEegfebUcoUqvML6u+OgP8W3WOoeFlI+Dksz37P3EzfRm91RTnsD+riC
         gvb09qE8GZxhZ6XfMmtHlZkDVTRAlU1PqJKEgaZIGb2oep7KAO76/sQF5Z1wNHB+z7lx
         bKafu9JXvyAl6SRM9Kle9uAT9/9hkn0B42DxcP2wOEXkMtuSN70670E/IWMcQTQwfQWx
         CSQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794286165; x=1794890965;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ToRZM5Foy++C1k59kSDpzw5FEF6siS+FDf6LC+WQ3Lg=;
        b=DiFiHw5fWNLLEg6D+/KchZV9MREuX/+Ejwx+nW4yVgONxYiwLKpyMkZ2jVqmfMDDsk
         L6r9JpXH+xCsxcxnWhT1bSwx7wciT2iugwvqMf3mpbjcPOaZLNyKgjx4uzIH8DNJUhGY
         oF+EHfWoSMMyXYUHejL0vvvquUF5nqBxXk84OKJNl1Vx6MGwUJjNR1fqKEjSK3ukWIAM
         XJIKEuOVnYHUlCoHdBlcAEH27zWfqxWp6MPtUqcP72rFmUMYSsrg5kgo5sfW1gCy55uF
         sAZIHNlI3EGf34iRDy7X8SjzdPnROUQSiswFKu4LF7V36Xyv7KL3zi5/88Ec6mpJNjPm
         y43g==
X-Forwarded-Encrypted: i=1; AL+hErFmwwTAiwI36pD67GK9Z797GRCz8i5auOHT4k+/pSUKYX+Tkv78FKlN0z3ID4DIejDmxm/EKmoE6npQ2Nc=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z8YjYsmLfHDmvXU0b4nhKTAzsF3l1kEDAKIihGWOI+xL2LUDCGv
	kXgI0DLePFWxTgk0m784IeyXEmX0KqoCMo86jMen43PonfjRNsAkyIAjWSiSgSBGueojPLmKfCr
	mVhgzJggV/3ET4IdZejv4u4uLevvsMQ==
X-Gm-Gg: AYBFou0Mf1LDTN0oGB3Dx4g7FhmXJWsnOxExJmdEcQQR93ifk2xt5JCwR1lGRwJRS/U
	NOaMCXu6zvP1Yo77jAm9kEMChwDQh1sLu9TTP29eXGdlLxp2nw4ZuN0IQEmUWlxTfhRzk7L3dsd
	KI/4h1EjwsJHFskz8LMR+R1M5tpf0XgdM0VSayGNirOAeL+PI8nay5gYaoQYrp6oJgvuqOWIyHr
	Yw3nkPz4ol3XrpH7Z2cOvwlzuYlJeH31yOI8BQawhnaPrxEl+MctOxBdObBhS9svwOLNSBGjjnU
	obaSq1zaUrWHizetkPsFEu6zil7mVYOH6wIbt4CG+xTJY9LvOI3MRAJ8DhloPiPQsZM/iTSZvgR
	f1JPDtPROdg+JUYa4g6cB6RV3Ah2xPBgeqzBX54i0ZDXYFS+fAKCeNpHeOYVM01orOhRBw+F2XK
	Kowa/Ahy60l64ZIKrE9KwW5PHKVG1wpJwyHbIXQAE/SBmy688=
X-Received: by 2002:a17:906:240f:b0:c41:4512:560d with SMTP id
 a640c23a62f3a-c5049699729mr80819466b.16.1794286164826; Mon, 09 Nov 2026
 20:49:24 -0800 (PST)
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
References: <gm-top10-20261015191529-g65-295aa0ac5211@mhun512.gmail.com> <KL1PR06MB694295F7F33B8FEDA284C65DF1602@KL1PR06MB6942.apcprd06.prod.outlook.com>
In-Reply-To: <KL1PR06MB694295F7F33B8FEDA284C65DF1602@KL1PR06MB6942.apcprd06.prod.outlook.com>
From: Myeonghun Pak <mhun512@gmail.com>
Date: Mon, 9 Nov 2026 23:49:13 -0500
X-Gm-Features: AclHuK9dEbOFpKZBzF18DRp2ysCfTdn-dJEdIFaJ5Bm7I0rvJVmVsW64xtISAdQ
Message-ID: <CAGEsz8F3XkYkLOzrncnLVNHSgfC3tZ_zYdVrTR4xavq+h9anhw@mail.gmail.com>
Subject: Re: [PATCH] media: aspeed: acquire IRQ after reset and clock resources
To: Jammy Huang <jammy_huang@aspeedtech.com>
Cc: "eajames@linux.ibm.com" <eajames@linux.ibm.com>, "mchehab@kernel.org" <mchehab@kernel.org>, 
	"joel@jms.id.au" <joel@jms.id.au>, 
	"andrew@codeconstruct.com.au" <andrew@codeconstruct.com.au>, Ryan Chen <ryan_chen@aspeedtech.com>, 
	Billy Tsai <billy_tsai@aspeedtech.com>, 
	"linux-media@vger.kernel.org" <linux-media@vger.kernel.org>, 
	"openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Jammy,

Thanks for the review. I will address your comments and send v2.

Thanks,
Myeonghun

