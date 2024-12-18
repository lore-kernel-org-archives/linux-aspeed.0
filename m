Return-Path: <linux-aspeed+bounces-282-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18735E77187
	for <linux-aspeed@archiver.kernel.org>; Wed, 18 Dec 2024 15:16:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YCy1z56Zvz30Vw;
	Thu, 19 Dec 2024 02:16:23 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::436"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1734534983;
	cv=none; b=UtckASngpUhpF1k0HzSTs3R0CGiXk+3DOjYWNgKtmV5kuLXnqjjW8AyVbBnfLHYVwUug0KRlcDoV9y7zHTLjNgfIfs5/fp5GPB12ItWiG/xiGiInGtq2GzssLP1fXrjTkuPrTGvluJUPw5FbNyPp0yDQVOapaWjRARIg8W+TQTnI+yoReJLWGjBeFEMPbN/OErgRyJeKPfbyc8ma92VVPFO7g1ukcR3+UcXivvrpuDdFSZ+DSOHHhR7mrx0MEiO0HEvxED1FrEqTaOza027MDTJtONmfZOV3KzpOW6GVw3uEiJj5mo6uvmGExIfks1s1228ccXaoJYhT9UQsvBldQw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1734534983; c=relaxed/relaxed;
	bh=9MDhAGexGxj9ILO+hAO6dd/OKAIC/9t4T9EMrSgxzeQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fc9BTLdsMkvfW0WmwSBcxiKX+efDx5N0NPCVaTfGrKRaxn6ajjl/KkrUwSIHK3qF+Kp/8fUjIscZU1Mw5jsPFFGJlviwfd0GhDxtXc4gQrD3K8NRVKcas1al1BqdEbETRxyP2QYow/bxZTvc2Bc516IWIiYGJIbDj4EKRHxucJ+K2Zw3JN3aWpIRJJPmoSqyKCdho5/tGIACFpWoqmRCsW0ewagJXLSbkt1Uy1/fjHtIhR0vITXx2ITlaEXHLk/Z+fblw6iXf6JFECaOCEcfJqlh/54ueofCdEj9i94QBjXygqTdpFBuPpezPjCuxL+s9gf5HvjcaCuEpwPyGSUqYA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=GPhTOIzC; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::436; helo=mail-pf1-x436.google.com; envelope-from=groeck7@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=GPhTOIzC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::436; helo=mail-pf1-x436.google.com; envelope-from=groeck7@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YCy1y5nDSz30RS
	for <linux-aspeed@lists.ozlabs.org>; Thu, 19 Dec 2024 02:16:22 +1100 (AEDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-72739105e02so7259635b3a.0
        for <linux-aspeed@lists.ozlabs.org>; Wed, 18 Dec 2024 07:16:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734534980; x=1735139780; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9MDhAGexGxj9ILO+hAO6dd/OKAIC/9t4T9EMrSgxzeQ=;
        b=GPhTOIzCt5bvR1PHNGvE/g04sIp+AU9JXmTpdbTj8OFEJ8ty0tsFMzrxhfBXILRdIT
         IwpKGT50BPy96cb69GXZueUosw1LwE5zuO7tcMde3PASq7ibaCznJgKYWEWYUK5MTlXC
         vh/o6WUOeYQQlTER0E08JbePAX7tFvC+yz74LK93p+zjtcNFmpYmdTXjO/vLBm1Kuojp
         lGWC+KAgUd77N67nXRhL89TzUQ18BSkj0LlN+RlSpTmgeqewX0P3wnqi8sr4QmgN3aE5
         F/fsXCDIeYys93KrknIj//LfUE93oqDXJ4EjL+/hNRfCfXyOrZ4bE3bxHeVaRZ+xyjCq
         TZgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734534980; x=1735139780;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9MDhAGexGxj9ILO+hAO6dd/OKAIC/9t4T9EMrSgxzeQ=;
        b=VyxsHe91HWBAhJn/X7ord16VsSGmZfnWMTlIvC9aigWmRpudOZDAU0KvD95cXEwGYf
         37v8FBJvXGVXncawUleG5l/O+ckWP7w5aSgWjLRs6dIf/DsihC0hniiXFefO4qLt6AGF
         OPatfWgdBiSEZLfXqDf7Y1LCzP9CjagxP3xe48Hnj6yaRYeGoW/fYR4yY7UndEOR5nXw
         4frb+8iT9oTfDB0+tDtL3pOKkzcR913g/gWu++wCyAED17hWDGU/iiBPBNckEqm+T4tR
         MxWGJHePZFPW9MdUufTNq80rgqYnjBbEpgxpvAcAv+wVCBVrZZFBVoqA5tF2FxIIkNpP
         UhQQ==
X-Forwarded-Encrypted: i=1; AJvYcCVRYz3wmjFYTjT/VYtg4pVndgyrq8CbxlANZa7USbrsL+9SoroRcN788RokcuVJaOU97rLjO48S53+rpkg=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Ywy9H3+bfP3UCytuvWXKyXT0/ROUgyN8hFdU0PSIFhz2jffgLIf
	ILqrMfjCXJvava09NIn+lt6lO+R0i7yNbWVs4lYegFo3Zq6hwq1z
X-Gm-Gg: ASbGncteo6SjdCaut0SmHUd6LL144rpfxmYy2XUZs20cuit4amtbN4JgQqYQbC01OsE
	ZcDSNU9u3IRyVA8E80NEzKR1s9TRiHyL104WAlR7yiom4POnoI+KVX8kgBrX2h4l84A5Luj2Y4w
	rIcRg5Z/+McZSTnDbPGk4Q6iXXUteNOk2JTAvCoHGtEsoZl0COINI77ib5ICR5x6T5jGOT/NqA2
	QJ6W6r/gZriSkRU8UORBuqXRhSOQOPt5QnPrwUiyI8VaamKRpKbdRdOJHDiKt29KMyVUQ==
X-Google-Smtp-Source: AGHT+IEaKoEueLcUrwUOhuGDoVwbtg1fKAFRiScp1E/Qo9EgYejA1PQnAX+xAskmVNSPNqS5N9ErCg==
X-Received: by 2002:a05:6a20:c6c2:b0:1e1:ca25:8da3 with SMTP id adf61e73a8af0-1e5b4820f26mr5938589637.20.1734534980432;
        Wed, 18 Dec 2024 07:16:20 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-801d5addb1asm6364819a12.46.2024.12.18.07.16.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 07:16:19 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 18 Dec 2024 07:16:18 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Ninad Palsule <ninad@linux.ibm.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	eajames@linux.ibm.com, jdelvare@suse.com, corbet@lwn.net,
	joel@jms.id.au, andrew@codeconstruct.com.au,
	Delphine_CC_Chiu@wiwynn.com, broonie@kernel.org,
	peteryin.openbmc@gmail.com, noahwang.wang@outlook.com,
	naresh.solanki@9elements.com, lukas@wunner.de, jbrunet@baylibre.com,
	patrick.rudolph@9elements.com, gregkh@linuxfoundation.org,
	peterz@infradead.org, pbiel7@gmail.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-i2c@vger.kernel.org
Subject: Re: [PATCH v4 4/4] ARM: dts: aspeed: system1: Use crps PSU driver
Message-ID: <d3de9f99-1cc2-491e-8dac-1a5d243e17f0@roeck-us.net>
References: <20241217173537.192331-1-ninad@linux.ibm.com>
 <20241217173537.192331-5-ninad@linux.ibm.com>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241217173537.192331-5-ninad@linux.ibm.com>

On Tue, Dec 17, 2024 at 11:35:35AM -0600, Ninad Palsule wrote:
> The system1 uses Intel common redundant (crps185) power supplies so move
> to correct new crps driver.
> 
> Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>

Acked-by: Guenter Roeck <linux@roeck-us.net>

This patch will need to be applied through an arm tree.

Thanks,
Guenter

