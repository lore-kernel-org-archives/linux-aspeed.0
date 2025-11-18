Return-Path: <linux-aspeed+bounces-2951-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77F32CF2564
	for <linux-aspeed@archiver.kernel.org>; Tue, 18 Nov 2025 22:11:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d9zMx4KcKz2yvH;
	Wed, 19 Nov 2025 09:11:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1763439070;
	cv=none; b=JH1aSfR0fGMrrFppZGpkcgtxRlxj7eQ/3sur1jlSgq4PTIQ0T2nrfIgE9A8cKcPRNoFrSyqtMH8UOmLAeTlMQyt/BKKHOy70qIYMllB7si53JZPKtpr2/Znx3JOSV+AE0mLExJsm9bSLKnrQH4CLTxj8j9fBOoxvoFyXEqGDDKJTgwAo71npglobvsdJ1ePbk1HOwrpV087F9Ya2CcfUiqUjP8vip+VszSHY4oqhJihDVSJehozfbEXgs4wUPcuASpU6B2tcBHYr9MwE73MzwKyCfRn1EfVrtQtx3yV5TsBGbNTDmUlPiM6vfmiRiPV2MjM3rYITu9QlqFQO17RWOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1763439070; c=relaxed/relaxed;
	bh=oC5WZ/7VfSXVPNYFtp8ZHIoPBfsAZ00riValRO0acVk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jbVrsaEbnk0gg2jhx4daTlXO4nw5DAqFNPBq1Tcg10zznJbKghnB2N5GRdy2hrOQ382ITet7I9VJR9NRP0fb2Go25Yu8PJ3ALyGtEJatKD+AVII7KCxkVkWIGdEcok7TBothK3C8oEfhZl/yq6IkFFyYwK0bMIs+ek1C+RaFaLaLn3ANMoo6ZuI1cow7meYm0H9zw4+ZXo+Cshp1EdRGBgTbmjQn7TX0MQzH0385jTt4S5uQ+Iv3WaPCfkxe38A/xjXUDzW6X8IFhLj2cNkz3iGRHHcBlCc12tQTdwRRBdQZArclShEYkyFKIvECq8U8LW6a/vSoAp7lZ3eEQ3uExg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=IoeiQ98Z; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62f; helo=mail-pl1-x62f.google.com; envelope-from=sjg168@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=IoeiQ98Z;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62f; helo=mail-pl1-x62f.google.com; envelope-from=sjg168@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d9WPp3PhCz2yG5
	for <linux-aspeed@lists.ozlabs.org>; Tue, 18 Nov 2025 15:11:10 +1100 (AEDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-298039e00c2so64090605ad.3
        for <linux-aspeed@lists.ozlabs.org>; Mon, 17 Nov 2025 20:11:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763439068; x=1764043868; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oC5WZ/7VfSXVPNYFtp8ZHIoPBfsAZ00riValRO0acVk=;
        b=IoeiQ98Z1R5Lr+hFPiuZq79E7TmQzEwTXssWV3loKOWjegikOmlQMFxQMonXNki5pL
         FGx6ClRVNiXmGA6DcVpB+nALU/3DijPTfCUOk7lTjcD3eatGP5PP9w12Jefn6Bis5isI
         7FRX0Kmdr16/4Zx4cN+dIzvOi5xd+mac/0gr135kr/WjmV1n+RuUXFSLZbK1fnl0v/pV
         BGZktK/IYcvtIpxAy8bBge1xwNPJdWeDjuTjLcJ+/fTYApHg7JLKBiJd3sS90ZgCAmEr
         bNOtxep7fvedStfOMOTpL5AHBxzWDMHKK56h5rQd5mcfdyFfXv9LlahfsqaMaqz7fmM5
         JMTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763439068; x=1764043868;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oC5WZ/7VfSXVPNYFtp8ZHIoPBfsAZ00riValRO0acVk=;
        b=mPcZ7s56HwygrhPg96TJ2pWLj+iP9q+av8Mm9q8/6VPyGNPGNuSj/XMmWCdXEmFnsJ
         ChHeYYKdTnJtlnG4wHIjIgX3cVXJfzI2pPcp/MREnbjOrBzh9P+zZ41QehAPW0rwi9N/
         5a4ypnCrYDFq+ff4Ss+7iD58QukOXkJD9K4YZrwsH+Z6xL7RRonK+I/sr5OKU6YQ6aQ1
         DCryvpxVTJvPORqr4+3vO2zW1CQpP/7FuNKBeUDBtDgZ4zzdnWCKpEFu0cJ6FxGPcoan
         Nhm2ZHdZJ3yF+pVF/zwHlmdye4A0Sui/BkOPMc3QSmRLBRoZYhIv4go2b/jjMVsjVqBs
         zL6A==
X-Forwarded-Encrypted: i=1; AJvYcCUk/C6bvFR5ycppzSP6Ip4eHe34REpjk7AOJzuSKvy0DX6o4UvrCKpUGxRSkwj14YbNz90AQ00OBzuTYC4=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwF5POY508YCV56jwPeECtvqgFF8Zso32ErhT4Cicbw4x8xjgGN
	nEosdvNDTz5ns28wBShImYhzXbigSG/o+jK+fK2d0PfYc/E9TZchLQRz
X-Gm-Gg: ASbGncsO1r+aVdsBuvTTQkis+4bt9j6O5CBgMpHfHBxT2Dm9EIIQlGqWHfPtKC5aUZ9
	7OR2awSLFQpj1BnKyaPgwryUI9S8Vb1BjJ+EZenx2JQWXRt8Z0hTxhHj8XWuSnEqMz0Oy6qQVvl
	G8h2JjvxAxpdjAp47HxWwTJ+WeKT40O0B6PETAK1nY7HJykklVQE0KT+s6XJMUB08ZBEuol6XWm
	1DWpYETsAL0hGSrTcZhTeej12kC7ND5Db129AT4GerlHQHHevEAIM171xR6SBChYvAmck32clUe
	hm7jDNvzi65K6dQDo9iLsffYFuPlKgalFgGzct/k8b6gUjJqfh/0XPyr6KT3Ffh6GjXSRB1mKE0
	5IlvNLoYzK5V5lZlnptU6UgHTrjzqm7ttv8cWYu76N+X4IEg5qGTR/mx7gZq9Q/fAYALxTktFtc
	uKPA==
X-Google-Smtp-Source: AGHT+IFbAdQLeXsJ9OGt7mRsvRAVrwQRoN3HqcPgt18qw6s9BCntwNDrABtfQk2EGbAMTkHuQOqMzQ==
X-Received: by 2002:a17:903:2b07:b0:295:2cb6:f4a8 with SMTP id d9443c01a7336-2986a76a1edmr149678665ad.51.1763439068321;
        Mon, 17 Nov 2025 20:11:08 -0800 (PST)
Received: from gmail.com ([218.32.81.133])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2cca00sm155514805ad.101.2025.11.17.20.11.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 20:11:07 -0800 (PST)
From: Peter Shen <sjg168@gmail.com>
To: devicetree@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Joel Stanley <joel@jms.id.au>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	peter.shen@amd.com,
	Peter Shen <sjg168@gmail.com>
Subject: [PATCH v7 1/2] dt-bindings: arm: aspeed: Add compatible for Facebook Anacapa BMC
Date: Tue, 18 Nov 2025 12:10:57 +0800
Message-Id: <20251118041058.1342672-2-sjg168@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251118041058.1342672-1-sjg168@gmail.com>
References: <20251112211248.3711889-1-sjg168@gmail.com>
 <20251118041058.1342672-1-sjg168@gmail.com>
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
Content-Transfer-Encoding: 8bit

This patch adds the compatible string for the Facebook Anacapa BMC
which uses an Aspeed AST2600 SoC. This is required before adding
the board's device tree source file.

Signed-off-by: Peter Shen <sjg168@gmail.com>
---
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index aedefca7cf4a..bcb874ebd9d2 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -80,6 +80,7 @@ properties:
               - aspeed,ast2600-evb
               - aspeed,ast2600-evb-a1
               - asus,x4tf-bmc
+              - facebook,anacapa-bmc
               - facebook,bletchley-bmc
               - facebook,catalina-bmc
               - facebook,clemente-bmc
-- 
2.34.1


