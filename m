Return-Path: <linux-aspeed+bounces-3539-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 800BCEEC2A8
	for <linux-aspeed@archiver.kernel.org>; Mon, 23 Feb 2026 23:00:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fKbtb6z5mz3c95;
	Tue, 24 Feb 2026 10:00:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::634"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1771845467;
	cv=none; b=e5mHm27qw7XB7GM80chnsnkuosw/kP/xUMZlCDZ0u4FaTGldmjyqFdTConCeDb7PonKI4au/aVPUczp7TVArynQfwgFm4NwBVWuXAKDK4O0TsA85JLhjUQPYZX8Nw5O8eV7wdqpz9SBkdhwKBZzAc9WjfPdxsA4Q9bj85KgFg8+Dj4FP6YLeapNIPEIH7I04i35vJl0bCcXPXlPEgC/1vYseDds2d1uHLCjl0fCl9JjZzA/xYUNhYfqJS9bM5ps65oAWo3l99wz2YPs/+Z+r34CaOh6hKsamPYBm1jai64lOkVT9znIgb6myubE9kO6gphG3ju/WrAJbVtZj+3MbQA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1771845467; c=relaxed/relaxed;
	bh=dEf9sD0ORFSG7AS78V5QZeKdYhd2SNplxEEftC+5unM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gPlDwIofYRbFrsVQk9xAc3VQH+PGwvKW1y3RqDAOVwsR4el/OPnVp8YxxGrEPPYrG5dZy0pS6LhqxCKksoeLpZbqnXXgWPhDmjNcHm6zoYqzoOaJv9piCkouD2eHd8kmj6JeNKhF4zGxiqQ845XjKIHA1JQtFqdJYr8L8j5hHhFRj42iRt8Zam4r21STgxF2lgh042g1/YtEfVwpJRre4SdPaXkun2M7CSMf7Phapq/uj/RD6NJoRQr6WYgbQWKYPD05uP62qE9XhaoTNAEzHdRoxIOZvNiXg123Q4z/Pol4pNdfToAr1r5o0AdhmVPplxjhbNEObv3+XvcudPWUKg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=hxvkJ74L; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::634; helo=mail-pl1-x634.google.com; envelope-from=kevin.tung.openbmc@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=hxvkJ74L;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::634; helo=mail-pl1-x634.google.com; envelope-from=kevin.tung.openbmc@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fKJHG66Dsz2yDk
	for <linux-aspeed@lists.ozlabs.org>; Mon, 23 Feb 2026 22:17:46 +1100 (AEDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-2aaf9191da3so26870105ad.2
        for <linux-aspeed@lists.ozlabs.org>; Mon, 23 Feb 2026 03:17:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771845465; x=1772450265; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dEf9sD0ORFSG7AS78V5QZeKdYhd2SNplxEEftC+5unM=;
        b=hxvkJ74LPYSgXkcAyDUSYK4U6KRlFjqO4+/FUnb4Zc4nMdNUlNVYHMH93iI2i+9Um3
         E3YnPraTwA/fE2JIRoo9DaTziBFfEN284kuagl9r9IEjxT1Mkd1XO2m/uxTpR99ulAkc
         MPeqezqO3MyyS3NHaq/8V1XN3XXHU9g6jMxQlh4LPLV8ddriz/8j4PfIBbfla0fzhxLM
         z2KJ7UQTZe/Vd6YDobnoV/pBtEfW8YjVYGfmSJZTHZC8G7UXyIcFKOVYAMwwyjB9H9Tm
         YYobgexU+aovZI01oZK62bR3kVJewUhHs1g/pOPo+fIMATbXlLR6An8LiSAx4YbhtZYE
         hItQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771845465; x=1772450265;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dEf9sD0ORFSG7AS78V5QZeKdYhd2SNplxEEftC+5unM=;
        b=LKcF2ZnxymrIxXVe+XonIUpyOg3aZaqZzzWYAs1hvzVQFs6h/BWpxB1ud7fMju1qRl
         DLGo0u2jZAmluhYUZzqUVquFoirlg/vGiXfULzkNKDAHffO0dyyE99mqGT7e70tOqjej
         7qp9wX2le1bgj+Ik5jEznrMGaMdKF5uPCema8lIYwBRyxoTkCR0hmIhnUBJlnVPQ1KRg
         GAhkiHXIMhQHoMePKi9GXPT09+sv7p73PD46qSYHJ0zz6+AkHWNx9SfeYmkU4Ezp1Lsq
         PkvzKu+fEm5IP+q1fECv/S5iG0jRNXIlxHBv/NDb45mpZRzlhBLkKqbLY+asvvVfC50z
         yauw==
X-Forwarded-Encrypted: i=1; AJvYcCXmvc+DNyrhPqRW18wkciqX/GEwxIUuGHNqkf+wy/wvFQL32b15e1TtarYNhmq3eJ6OfwJhAb4qTbaRaM0=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yxl4EAohlzUSP0xS2HRR2TEs/+l1CU+YhPujEop+sG5mtUY7xtj
	Qja8KgyjlhAce0BcFyVTMkAsGPv3OtFM1DOzpAB+GmoyLFe/Q0zbk0E2
X-Gm-Gg: ATEYQzxXOQFBsOyeH8TPslWkVRqvCMZO8/0O+ryZ8IeHj/v4u49tZAHwXJq/Nbs9pNX
	aw6BsBWfO3pOQws7lfqO6kw1ZrVbHCxJw5h2nb5Dl1/xJM1pWMYiFna5SGIpUwwHtvbNOkU8yL5
	cc+2YpJg4B+tf0rs0vPiEXEdo8T3g94L2OrHcVVS7pBvIcYSJ3gX8w6oUSB92ZWNwOBvFbubkVN
	6TFSdUrHfLDucBvz25T00zuOGVatrqRxwtgzwtE78jQTliW5xaX5Rl6b6RxZg2oZk0O5y8WpfCu
	6yqHltt7wZC72N4/9YBBoG/9vaZyNmU1kRe3NDsxOMpGHIO/NlQut5v9L1wr1oPyz/8nDNn2wep
	MjIZ/1C0aMYdQl/p2ZQZibpmjbzINoQOFwp7Xm99O3u1N4Lf8FTpIEy3z1xBkfw5Yv8ghxZkUIM
	jwrWOXq2Uhrh89/HwQZx97dkQ6uyUrvuYxUlvyXFnteelhTB0Xy9a9EfHLrazDlZKGdsqbyNaZQ
	R20bJUQzoTEQYGBqf2q2potCPmseC1mfXqTxppG575KJBnF88ZMGjNu3RTKjA4HIknoE/0PNV26
	rO2qFvqog9vTz7uUqlNX
X-Received: by 2002:a17:903:1a2d:b0:2aa:e817:1bd3 with SMTP id d9443c01a7336-2ad744e1731mr86659805ad.29.1771845465072;
        Mon, 23 Feb 2026 03:17:45 -0800 (PST)
Received: from 2001-b400-e3a6-b683-040b-c296-04cb-fbc3.emome-ip6.hinet.net (2001-b400-e3a6-b683-040b-c296-04cb-fbc3.emome-ip6.hinet.net. [2001:b400:e3a6:b683:40b:c296:4cb:fbc3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad74d36911sm71799335ad.0.2026.02.23.03.17.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 03:17:44 -0800 (PST)
From: Kevin Tung <kevin.tung.openbmc@gmail.com>
Date: Mon, 23 Feb 2026 19:17:34 +0800
Subject: [PATCH v5 2/8] ARM: dts: aspeed: yosemite5: Remove ambiguous power
 monitor DTS nodes
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
Message-Id: <20260223-yv5_revise_dts-v5-2-fc913e902488@gmail.com>
References: <20260223-yv5_revise_dts-v5-0-fc913e902488@gmail.com>
In-Reply-To: <20260223-yv5_revise_dts-v5-0-fc913e902488@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Amithash Prasasd <amithash@meta.com>, Kevin Tung <Kevin.Tung@quantatw.com>, 
 Ken Chen <Ken.Chen@quantatw.com>, Leo Yang <Leo-Yang@quantatw.com>, 
 Jackson Liu <Jackson.Liu@quantatw.com>, 
 Daniel Hsu <Daniel-Hsu@quantatw.com>, 
 Kevin Tung <kevin.tung.openbmc@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1771845456; l=1501;
 i=kevin.tung.openbmc@gmail.com; s=20250924; h=from:subject:message-id;
 bh=9mIn+NRMcnY3nQa3xJUsbsqiUrUJYrQ5MBs5E/B+nyA=;
 b=6Y7zZJPug+L/D4hZsJuZ8qj0dU08TZ1l9Yv+yjr0PCQyZ7UQs5aT10ImulnrtBzWJFP1+lqkw
 R3+pUZQKbQ+Db8upoOwg3GGp9wJhWjkORgkT0J6Xe/KwYjRNQ/B+bSc
X-Developer-Key: i=kevin.tung.openbmc@gmail.com; a=ed25519;
 pk=PjAss0agA0hiuLfIBlA9j/qBmJaPCDP+jmQIUB6SE7g=

Two different power monitor devices, using different drivers, reuse
I2C addresses 0x40 and 0x45 on bus 10 across Yosemite5 board variants.
Defining these devices statically in the DTS can lead to incorrect
driver binding on newer boards when the wrong device is instantiated.

Therefore, remove 10-0040 and 10-0045 device nodes, and let the driver
selection is instead handled in user space by the OpenBMC Entity
Manager based on the actual board configuration.

Signed-off-by: Kevin Tung <kevin.tung.openbmc@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite5.dts | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite5.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite5.dts
index 7991e9360847532cff9aad4ad4ed57d4c30668a0..45b8ac2e8c65a4f672e64571631b7f6944f26213 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite5.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite5.dts
@@ -674,20 +674,6 @@ gpio-expander@22 {
 			"PWRGD_P3V3_AUX","ALERT_TEMP";
 	};
 
-	power-sensor@40 {
-		compatible = "ti,ina233";
-		reg = <0x40>;
-		shunt-resistor = <2000>;
-		ti,maximum-expected-current-microamp = <32768000>;
-	};
-
-	power-sensor@45 {
-		compatible = "ti,ina233";
-		reg = <0x45>;
-		shunt-resistor = <2000>;
-		ti,maximum-expected-current-microamp = <32768000>;
-	};
-
 	adc@48 {
 		compatible = "ti,ads7830";
 		reg = <0x48>;

-- 
2.53.0


