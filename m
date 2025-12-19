Return-Path: <linux-aspeed+bounces-3171-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BD7AE668AF
	for <linux-aspeed@archiver.kernel.org>; Sat, 20 Dec 2025 06:45:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dYFJx2q4zz2yFg;
	Sat, 20 Dec 2025 17:45:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1766141025;
	cv=none; b=Rk588CM9yUEmXZRHZIjXvZsmwCqZp5wx173013fDtBOAfTwsx4LdqzlMtP3/hGQCHaOKwb+96RfxaEj677oLdBR+vGLN/HNJzPUJZBnZalj+1OMTzwdl5N4xkrC92nYoeR2ugKGcq/nTWAsCf1jrc9pbfFxgM2dk9gPM1XpMhEwMmUfSoqWA5nkvXe8pXTkzltjIIG3makqvSLAnxPLTyjV7wqvLQ5BvL18M4mU4+E7Jr7XaDPzOLXRR9rXisdRiDNR7ge8Vf62D/X5dIhZk0GywwzZXOSsuIr0PiAfT56frz3gLzM5Npi5NoPZLPcF6L+AzkeXVE6XWhOU0lTQNjA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1766141025; c=relaxed/relaxed;
	bh=K0JIeF4k33yI3s7+w9je79opOs88ZXUfAhVsYJKG2Bs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=YFgTON0cYcpiKBT+cIMfkkldc9jSXi2R3Vbpi4f+krr/H13/Kwn7D98QNrAskkB2/zyiQmMhDSl+Jg4nnqMPd9uctuPzIyE2EZyRG2YqKjGrefiWMLzynvVDawLI+VLXjEeEuAVOQvykVEcrZEMy2CpyRLMToEh1SRrYxm/QYHWkTLE082t3wEZsiDp/Kg4unKUkd0RFE+ki0H4R/sv3R7SWtGlf0nDo2xKw+PPfyRBtuFy6nFbpNTH3yOJmzRzrnMkGarS3HnzecqjvGU2ggUHMrbS2yNxXly7r5lT0QFYUlh47mfDKrtZqBROuAczjmvyEVb5bOerR90HgLHymXA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=HMheFPC7; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jX1tbCvU; dkim-atps=neutral; spf=pass (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=krzysztof.kozlowski@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=HMheFPC7;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jX1tbCvU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=krzysztof.kozlowski@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dXkfT0ZrDz2xfK
	for <linux-aspeed@lists.ozlabs.org>; Fri, 19 Dec 2025 21:43:44 +1100 (AEDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BJ4bxts4145261
	for <linux-aspeed@lists.ozlabs.org>; Fri, 19 Dec 2025 10:12:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=K0JIeF4k33yI3s7+w9je79
	opOs88ZXUfAhVsYJKG2Bs=; b=HMheFPC7ELF2bkYkX4Xae+GU2O8Z3G7geqAIAd
	q9zPbeCEBbJAU6rhixZDYKR/1BTLvK9pbXhckUlZvqO4yn5yJ46jBQz+c811k6xx
	YslPFRLtjhMjElfGfClz/GorGQBEZza644n2wMe+izoGX4jOIgQC1NSfbR9Iexex
	GhY5srjIRGQVuzs2Bm9c1XOTpw72IhOklLIrdqzmnaq7TOKWGbTF8UHfivSLTlwi
	VF3J94Ku6gHOiBnS1v8b8es6Ui72M5fWjLSPn64mNzryt08xrbKsYrPW5y3/L5hg
	cxgavzAR2a+3e5+x9WPEBIckCF7dQvieODW0jGUe2c4oxozQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b4r2dt9e4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-aspeed@lists.ozlabs.org>; Fri, 19 Dec 2025 10:12:00 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4ed6ceab125so36761001cf.1
        for <linux-aspeed@lists.ozlabs.org>; Fri, 19 Dec 2025 02:12:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766139120; x=1766743920; darn=lists.ozlabs.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=K0JIeF4k33yI3s7+w9je79opOs88ZXUfAhVsYJKG2Bs=;
        b=jX1tbCvUCWUcOZfyC2N0QZ/SwgVXSXmNRY1thiPQA5fSJLzZ6q9ErfG9VUZ+xZHbO5
         v12wkw62ojHJ04IGG8yn310NFuZ8iTC9ze9Ge8L7UzXbc3/D/OeehdA8Gandm9y93HcM
         Anb1Q6o6u19zDQJKD+Mo8JsizJHHr21R84+FsAf+jiOh7v2jUd8MO/pR0HPWBSkS2RlA
         g/AaJXz2YyD1TjXVPaOza9ZnZ12fFDktcDFNHtsr09RzTWA8PuPDrZFuRQ8b4qk2r2gy
         hNTrh5Zw+YWZ+17nZyTXp8GZJr8omafgvgoIyzdyJ5v/yq74/+0VM9mWIkXEfDcyOaUF
         vnAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766139120; x=1766743920;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K0JIeF4k33yI3s7+w9je79opOs88ZXUfAhVsYJKG2Bs=;
        b=aLpqMXui+oqVvY9g8Hr41Y448rUTBc3oDBogWcg3QUKFBwvJZptzaFjrBTLKzB1DRT
         p4m5MWRQwzvIeeg8gtRys9z2zDu3WaZmwcI0GExB7kNsRq5OHx209Qgsmqq8g9ewkn4+
         9WXRV6ejA//L7TSiok+eqWDe50M6DqMHkseJl+SieX2d969ZyU/1Ilhoy2QFpGVRGA4L
         zMPaiACmpNB/W/Kstq3pzo7zm7ppQKNPKWAFygqmyjBDlgobFPXzCJhnmQI74r13Yku9
         lOOV1iJwGybc/B1ndJa8V+1C0oObQVT6OnYB4LPk6PCTWlArtLNI8UIGjKjU6oTGmpq+
         RZNg==
X-Forwarded-Encrypted: i=1; AJvYcCU67HchVWJDlRhOaG0o2Lc9b/PaBjo8fholsMiDzj6r3IjfCQ6PrOlv+Xssg3mzDnOPGjOC4MpUnTUrnjs=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yyjk7vdkT05R4qBG0VPdqv1Ugaq7MJ31JxITQQbS/tymHkp9iyR
	MkPsYGsimM45nPoJGqgZrI9QThA5GSB+rUzv5KETh061ZyTb+MJ4BZ2LpdyiZMGbXV4xMHWu89R
	u2zq0vQqqfVaYLeIg0bgVrKsOp/24WgsXYRT/yGNGzLpqD+suI/nPCPAfEkb+P2+XxbcJ
X-Gm-Gg: AY/fxX5MMeHLy+VSw9fKdO2eW9GeSiFsS4C/+w7n7jkb+XZnjFfdi+zlx9kPqcFvCNz
	1EYRyvQFpr+M3Von0ghZjKBxB0E14Utyg6CTRmOcy/9VreMNFMklNsHw/RLFRVY34EN72kATULq
	vCJQwsM04hthliyBqqD8X3yIIlEw2YPxAySbsgw7T7QIla6i+MLFoDncfV/bkGWE6g0/b29lyK9
	NsLzmdLSTW8I/DaTkRcnEkg+aVqhqUUxAUSQD6q76Ug4p6EfIw+q7bJvGiCZq61UAYep7m56YBU
	+yEOpVXnNRXLeFnIibbhw0gV0CMfqzRoC1GFdWGymPj8rKQ/bJr+a9gey5QakUNPYF/dTdpp7Rj
	Y9Rjuv/be4zJNR2AlaffUGHAvkpxQQrt5KtKqYfBMLFPQC1Kjg9H6w+EJEoVdk8E/fJue
X-Received: by 2002:ac8:57c1:0:b0:4ed:142:ed5d with SMTP id d75a77b69052e-4f4abd79a7bmr28425121cf.50.1766139120246;
        Fri, 19 Dec 2025 02:12:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEQU4yzy9rycPchG6dBt6pBK+cvMRNb2Vm1Cb+gznhIXBG26wgDUcba13nJs8Ny0xZdgBevhg==
X-Received: by 2002:ac8:57c1:0:b0:4ed:142:ed5d with SMTP id d75a77b69052e-4f4abd79a7bmr28424891cf.50.1766139119837;
        Fri, 19 Dec 2025 02:11:59 -0800 (PST)
Received: from [127.0.1.1] (83.31.98.88.ipv4.supernova.orange.pl. [83.31.98.88])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037ae2dbesm197282666b.29.2025.12.19.02.11.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Dec 2025 02:11:59 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v2 0/3] gpio: Simplify with of_device_get_match_data()
Date: Fri, 19 Dec 2025 11:11:49 +0100
Message-Id: <20251219-gpio-of-match-v2-0-5c65cbb513ac@oss.qualcomm.com>
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
X-B4-Tracking: v=1; b=H4sIAOUkRWkC/3XMSwrCMBSF4a2UO/ZKkjYVHLkP6SDmeUGTkpSgl
 Ozd2LnD/8D5dig2ky1wHXbItlKhFHuI0wA6qOgtkukNggnJOZvRr5QwOXypTQcU40NM2hjH5hH
 6Z83W0fvw7kvvQGVL+XPwlf/Wf1LlyFAyfeFcKjZJe3tSVDmdU/awtNa+2GntRasAAAA=
X-Change-ID: 20251106-gpio-of-match-23b24cddf063
To: Linus Walleij <linus.walleij@linaro.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@codeconstruct.com.au>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>,
        Srinivas Neeli <srinivas.neeli@amd.com>,
        Michal Simek <michal.simek@amd.com>, Linus Walleij <linusw@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1111;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=Qe1g6vLAqNtu7EEUBKJshU91y2FQGa2X/OwnQVn2wOM=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpRSTonfljpnWP6hKoodhrhaSuKLZHgGp/wZolS
 iMrHOuyizSJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaUUk6AAKCRDBN2bmhouD
 113/D/98lfgktoyZkbyuDmhOQeJP3DbNTJM+fle2plZVHI5+Ak7Jt44MnYcfk5eZJR2diRg6BCU
 VjDf0E34stmkgnAfAiE+KGjTCMum4uo0E+7qi3MD54G3tM8LwRAadJkJLxUz1ytiWMqY3ylxiQI
 0bA66UE72MQAfew4h0k9wiCWudRlU4noYnF4t1nsIixYx04vmc7eeAK9roTbvOxu9MqEyeBN6V1
 PiDJ3YrUA6C3a3A80vhJyzEERpAmXrYS+6nmJ12F6cXQbrJwyG1g1gxBnAd/GYI4glQsJP1PBrY
 WwytvmF2SDHf2N/tpGQQzRSvEf0UNNOHaQ3bsyxY52ah8NuLTmqPIQcMX+wV+e/JTPii8vwVdnk
 +rp1LqIrgk499zT5Zn9jlR4ecz1nmQaoWsa5fMDPYfB2FWcCplhDHYZGIyVBVBJTuXZGLapApL7
 5r890r+N41BQQkMRwmEPfQaqbae6PkNC9MlOx644o8d681A06Rh7e385j/ouQQcK/SRNxkIDMo4
 Ngr9Sa/lqpMnpzKfdTQ8hVJO3i57S/rkJXx81olk2vnkdIIpfB4LWuJF8yTsKgYThPPLmd+4O1U
 qcBV1fnKQntNrfzhIVzptEd368c6tOISvliw/Pt2LsBmdCrLM8o+HtDzpKkfX7LdHHOqxjvdWzY
 LXMWBKFUMqQdXCg==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Proofpoint-ORIG-GUID: Gowi1_Op1J1PNAztPAkWJppJb11sI6ov
X-Authority-Analysis: v=2.4 cv=A7ph/qWG c=1 sm=1 tr=0 ts=694524f0 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=qe4J/qXhiWkb1JZGYKbLYA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=bC-a23v3AAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=Gv4_7YmOpO5FjsplTRIA:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
 a=FO4_E8m0qiDe52t0p3_H:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: Gowi1_Op1J1PNAztPAkWJppJb11sI6ov
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE5MDA4NCBTYWx0ZWRfX6AbA3fLX0F3S
 U/oqILDnlwfylbMVU6F2fuPkrIgZO3t7xqm6mM1GRDhjKgTUXBsFDabByLrT11M0RebAIeIAxcb
 vYwjaRKN6cu3W7+PRs14bRkBmxxIOEbIptZbdmAU92gZbDvDXD7eB+yWO6N+qvzEjZUDGJ4UOTz
 KfxrAlIYbh3W/8LVzZIJeo/Sm4z7TRmzkmpeMCZlaeW1wv4ZLJDQjTO88iPj1aOv8lD0y+qo4vW
 jGPQH8men0crnIQYgGt49bTTVT+NnbLvtQaSNf/BmvA7TWEHA1iYmPzpljGiBjLtNHKNMlfwpAK
 JosneX28whj3TDDPxKfACe4eSTzNqHbMku1/CJCU9LIxWFAOM1UyFjqAjmIscmGuJaS5xhdMcgv
 k6N7zNOjSVnBTJ5u33BHpNJigojDvyhsTa/bP2FXK13TQjD3Fc4oZUTy4+iZSN3C2zNkkdJ8DRF
 KSYNdz60upA7HqbU0pQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-19_03,2025-12-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 impostorscore=0 spamscore=0
 phishscore=0 suspectscore=0 malwarescore=0 clxscore=1011 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512190084

Changes in v2:
- Drop applied patch
- Use device_get_match_data() as suggested by Bartosz
- Link to v1: https://patch.msgid.link/20251106-gpio-of-match-v1-0-50c7115a045e@linaro.org

Few simple cleanups, not tested on the hardware.

Care has to be taken when converting of_match_data() into
of_device_get_match_data(), because first can check arbitrary
device_node and the latter checks device's node.  Cases here should be
safe because of_match_data() uses 'pdev->dev.of_node'.

Best regards,
Krzysztof

---
Krzysztof Kozlowski (3):
      gpio: aspeed: Simplify with of_device_get_match_data()
      gpio: creg-snps: Simplify with of_device_get_match_data()
      gpio: zynq: Simplify with of_device_get_match_data()

 drivers/gpio/gpio-aspeed.c    | 7 ++-----
 drivers/gpio/gpio-creg-snps.c | 4 +---
 drivers/gpio/gpio-zynq.c      | 8 +++-----
 3 files changed, 6 insertions(+), 13 deletions(-)
---
base-commit: 26ac2c4153a2c543a4ef3dee421b46bedb0f8f0f
change-id: 20251106-gpio-of-match-23b24cddf063

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>


