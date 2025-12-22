Return-Path: <linux-aspeed+bounces-3228-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 880EEE9271B
	for <linux-aspeed@archiver.kernel.org>; Mon, 29 Dec 2025 01:51:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dffMV53YXz2yFx;
	Mon, 29 Dec 2025 12:51:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.214.174
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1766389627;
	cv=none; b=QIGTe1ZlvHrA/LLPhl7oZqBpzxe0JiUwR4LdmlcHWtnUrK7qG3CVQaYphtiYmLBqmMHstmWhArI+7IAT+N27t7Okh3W9/8a2e3tPW+3ICoy4OCo0JLy5ZhuvXur0OZnrU7ooOoHvUiZxAxSAe54S4NhBf4XU/tB6CE0EzqKVfFjudeWd5KFfOH8eL/Xb+wANn71JRuZk7HdrrSjAa18sYuAKWUOROIQKtwwxJaJ2hAfrFcv5D9YsC2cwHb4OvGTZxmyfh7lbdJCo4V8aiSWzH90cPsxOcmrVzYTw5VyYzI06fgaTDcLmPKNfKxQAReG+5m1osJ3eTnjs6V3GeL6/Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1766389627; c=relaxed/relaxed;
	bh=FhSoLSk0toWUxTDlJMgUw8U4nRCTEhSOzea+DI4TDjA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dK20215F0TL3aIn7txaxYL6ZpTvpfHqS2TffEQ3yybFMp9OvIOk1wuEpNnkzVY+JD1Nlp+4wKx1sLVX6wDWe5rs4Qw3JRTdnisL1ygz5ky5QWrgdt8cjmJcaJ+mFHHQIVf1Ioh8qzMr43aFdXaKkmRzLaBxiB4oNr2iFIn3g7UBu04rjpKdySYz8gQrUIpS3MYnXfniaDQrjnT1dt8JXlCWw3f8Cul0Py83sSZ4loIoPLoKfPRQpY/QA8e+vlEFcW7YhCYLPJh1Rn39XwClS428ZnsD3My81Ta4Y8Mpp6ZNaah6mP/5MBOrw90ydCWUqqyvaSIgwCXxg0GDygxBhPg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=NNS54IEE; dkim-atps=neutral; spf=pass (client-ip=209.85.214.174; helo=mail-pl1-f174.google.com; envelope-from=kylehsieh1995@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=NNS54IEE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=209.85.214.174; helo=mail-pl1-f174.google.com; envelope-from=kylehsieh1995@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dZVbG5jNVz2xpt
	for <linux-aspeed@lists.ozlabs.org>; Mon, 22 Dec 2025 18:47:06 +1100 (AEDT)
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-29f2676bb21so47843355ad.0
        for <linux-aspeed@lists.ozlabs.org>; Sun, 21 Dec 2025 23:47:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766389565; x=1766994365; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FhSoLSk0toWUxTDlJMgUw8U4nRCTEhSOzea+DI4TDjA=;
        b=NNS54IEEw1fwOfRHtC8VIlFITlZhw/gmvUTRXfoDkyi1LvzVHKG+KoeQgXf/q9b4df
         tqHwPInOCZIiNGqhlFwekGfnDVN7J7VrjpFnqabED8k0aeSpP/Ai0Uydd4OqLeO8+1zO
         K89LGNGmluRNwyo3GssLhmR5xOl3tp9RM502VanuXk1XeoyrY4wGOy4lhWPJbF8wphju
         4xIfBap0maHb2BWHTHtOG2SguZIjLqSZjRe3H89tWxfALHdEwXTN/Orxsz6DeR8i8ZRy
         DzvtgWjsdwEodhOWeztWon15+V41raVgNXU4gK9S3FMXxBiS5kqcHos90RIGC9ivxDOA
         uk8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766389565; x=1766994365;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FhSoLSk0toWUxTDlJMgUw8U4nRCTEhSOzea+DI4TDjA=;
        b=EiLc0dAYRjD25gaYmLTvzcMYfT2iyBlrVLnYP2WKepjGR4EBTl+SI9SU6SkcDeIJFd
         7u9DH8yQ7in+mjpRBk8TvbmSPCmPPYURtyNl6QNrmW6uPycXMTeFOeFwxCJs+6ZqbbeX
         UDqVFsPJXc6IzWDwjjxjMexOJe3vNEfWYIE+/09Sdq05009Kh9nUvsGMGOj07AKJuX5W
         D8syiQ3dMW1mBw1Ze3IWoxjR3NpfOapZfRI3vZl5+5KJJ4wDviIoIhtJadbaHiAG+afg
         wjd0ok42ApmCDIctxusneNQMsKHrFcKUnEc41AWN006qwGIdzfuJ5UPRZumGyKNkKaOb
         P8kg==
X-Forwarded-Encrypted: i=1; AJvYcCUpyVN7e55Z8TV+FU0Loc2n4S/EiMF53ehMaoPUlr1GhvMlXGxiaaPvww7RtDWg0qGlDYTtUkzEHw3AoUA=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yy8tPyluwfcmxQNXLluBiUOwRX4G1QT87Pz1+DhyGZAntMkhwrM
	tzrNxKJJArNnV3Asnb6tV+Yq4Edl3gUCe2fBbRviWfhIQFZBEwk5aI60
X-Gm-Gg: AY/fxX4cBY0C5oMOoDFTAcqMflIvTDMZC0dTXcb0xzP+K9Ce7tuHJ8G5XeRBMJoesnd
	1/DCrMnP6xZbQZB99sXjti/0oa0GKfv4t/hEPFnJmDj0mpH7nlBK6NAcQlIYsus9GmFhkQQCfq0
	Q3UhTlRk6WicBmgf7BhwqZKZpjbD1fMtIf2LzlEi2WSwZ0Kofa4aoF6CTUjUY2B6qgLaojBW56U
	XNw7ozlqt7hn6VAAXRD/GhjBCSFHf07vhMn0u4rxywbcRhyEKsXIYHIo49ntzTsJG0rkPKq41Dd
	G2LgDczV4UuxwSa4gsmmbMM/ECuU/iZr9z8NC1MPPCuiFP746W1m2LXlPRACzEAScM7j3wIfIPd
	5PA0PU/KQEsXpan1p8v/muYLmA08GQEvUZELqhYAXwUbhpvLkezzlWI4f+8FzH1qbbIOQsTFmWo
	bQw9G0o1u7uUIZcWg/oqFSgiVIR9eGtFTYxS982keZv05yD9cr7aRvALPz00hHMGmUvvmvSy2yB
	fjwpQ+XH46rsZTQ
X-Google-Smtp-Source: AGHT+IGhqnlFI6apowaKrJQSUtx5Uo4lIBRTl0LtnZmF1bt+yilUxHMwYLSA8kTDgE5JJmMxhl6Q8Q==
X-Received: by 2002:a17:903:32c3:b0:298:616a:ba93 with SMTP id d9443c01a7336-2a2f220cc86mr83489825ad.9.1766389564695;
        Sun, 21 Dec 2025 23:46:04 -0800 (PST)
Received: from [127.0.1.1] (2001-b400-e3a0-2ead-fb96-4f50-681a-bce4.emome-ip6.hinet.net. [2001:b400:e3a0:2ead:fb96:4f50:681a:bce4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3d4cbb7sm89605105ad.59.2025.12.21.23.46.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Dec 2025 23:46:04 -0800 (PST)
From: Kyle Hsieh <kylehsieh1995@gmail.com>
Date: Mon, 22 Dec 2025 15:45:43 +0800
Subject: [PATCH 1/2] dt-bindings: arm: aspeed: add Meta ventura2 board
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251222-ventura2_initial_dts-v1-1-1f06166c78a3@gmail.com>
References: <20251222-ventura2_initial_dts-v1-0-1f06166c78a3@gmail.com>
In-Reply-To: <20251222-ventura2_initial_dts-v1-0-1f06166c78a3@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Kyle Hsieh <kylehsieh1995@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=839;
 i=kylehsieh1995@gmail.com; h=from:subject:message-id;
 bh=6cfmAXzuvyWCriW+9K5ER4DTlYWIvpG7m38YclJ5GzI=;
 b=owEBbQGS/pANAwAKAaWDQrcJVsSBAcsmYgBpSPc25eqwxQH4wWyUJKBjJILcziSHssSo8q/H+
 3afSzty0vuJATMEAAEKAB0WIQTJHsaNZOdY+THGqJelg0K3CVbEgQUCaUj3NgAKCRClg0K3CVbE
 gUTcB/9THA8dYDR325r29fI/xAe4YjAOYulMOMSzWKqhT8wmQoP3GO2VZ1yoyPxLUg4w3f5YSpW
 9T4pKSUq7CoInDyDV23/BZ6z/27l/O358C4Q4Vnz4xIOTOqhXETyLAxAViA9OKDC26T39y3fYKL
 XI827vGlVlVwZkVWypMOQSUpx2HTUAgTKpt7cwcAHHs/oYaIgc543Qn7dX/UvOFVzcB/nTDQADw
 PLdVHv8ySkrc6x5IlC+romxV+9DWyclGtiSz6SxZR9+JnAK/gLzP+1O2PGqCzVqk06GViCnrhhj
 7PTd9vbIeyyur7sw2e0MlNrA5nIHc6rHQUzY9ttNMKLlNIhK
X-Developer-Key: i=kylehsieh1995@gmail.com; a=openpgp;
 fpr=C91EC68D64E758F931C6A897A58342B70956C481

Document the new compatibles used on Facebook ventura2.

Signed-off-by: Kyle Hsieh <kylehsieh1995@gmail.com>
---
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index 9298c1a75dd1..24e19b8d108a 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -92,6 +92,7 @@ properties:
               - facebook,harma-bmc
               - facebook,minerva-cmc
               - facebook,santabarbara-bmc
+              - facebook,ventura2-bmc
               - facebook,yosemite4-bmc
               - facebook,yosemite5-bmc
               - ibm,balcones-bmc

-- 
2.34.1


