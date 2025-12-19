Return-Path: <linux-aspeed+bounces-3168-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE6B4E668AF
	for <linux-aspeed@archiver.kernel.org>; Sat, 20 Dec 2025 06:45:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dYFJh3FRMz2yFc;
	Sat, 20 Dec 2025 17:45:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1766146406;
	cv=none; b=Iw6g8B3YODH+G5PBrWv9a5q1Z4BzqfiC+jOxxohJkvd8BXFlJB0LFcc8l1RoYuJFgBYMwHpkFQOoPX1yr5iwU5mwiTGaGYP8Hb/o+t6ZYkfh+fetqjOZUE9dti4SKD68QvLTbUTC0NdEM9u9z9Y0sopGb7+/ksSt+umxTZGEQmAFDJju2LlhD+1Lx9VdepDrlDWZkacwCYWNtGQcv9vVm2IO5Cqb8INOML1eXRJrqcNuhMrOWOt/xRU6UjHowa33rLwPCCe0V/QHE5rv638R6cgE0t4cxaLfy4bJflxEH6C+hVdYn6QUyZLxmCZ/V8l/MYMgz8fZGpY3Kkab+MW3qA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1766146406; c=relaxed/relaxed;
	bh=Z2sMzTB/9S9jACJVAZhu8V6NoQJ8NfstFRgn4YsuRPM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=F3/kFDg8hDaDHyzpcjqq2QjoK3m+ssxkJilb4u/QNF0BlD2NVTTuZpuGQa6uvfZEv6jnUDrJoF/Ww+Cw39xuIlRqdwfaYlOLGe5/MM5MvWEsm+JVUJlN1Khw3l245J9A2YWII/mkglt+art30CUrVlB7AxnxAg4UFkUenf/et6H/FngivD4HQawvo5RTskAI+7x71Duq//WKbcL8tmO0jShIY0qKY7xDSt1tIWkiWOA59U/xymhVYZYRcT9ySR00KvV3q/yAJZFXiYE12iFNBfPZ1Bc9UGEuYLw2iU5Qh2F140omDwQ/mlgGfqt7xW6X1psbiVpkNGrCn2lhI5JB6A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ArDOwSQo; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hp7Vn0nr; dkim-atps=neutral; spf=pass (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=krzysztof.kozlowski@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ArDOwSQo;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hp7Vn0nr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=krzysztof.kozlowski@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dXmdw29rNz2xfK
	for <linux-aspeed@lists.ozlabs.org>; Fri, 19 Dec 2025 23:13:23 +1100 (AEDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BJBO9eE4145756
	for <linux-aspeed@lists.ozlabs.org>; Fri, 19 Dec 2025 12:13:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=Z2sMzTB/9S9jACJVAZhu8V
	6NoQJ8NfstFRgn4YsuRPM=; b=ArDOwSQo+YqI3EHenFVl5aRXCnr4AXDFvS8idW
	YlO5MDSIwCePpkbUS8iBjxeEvlYlIkhLu0ZpUshwIKfqy7Lpa3FRhql9WuLWxtPZ
	if39TDV/R6vYHFhomHWqInc6l4Yd588k+9DzuTASCm4zMNB0NUeeDAhRqYy8NKHq
	iO0PkpiR+LDGinas2TuEDhQ654Z9MzPZIYhe2K1o/ATpCNF9Gnuu/FqAzHLr6z3G
	2dkagBsZssQUN+s82A2zxGTmvGxzxT2mdSTttZlLGqToDYr4OZrEZdzQyeu3afMK
	SbORA2cy6rwU4aDJ4LKaaF76qevNz7q1aWZgEi9h/St9k9AQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b4r2dtkpr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-aspeed@lists.ozlabs.org>; Fri, 19 Dec 2025 12:13:20 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4ee04f4c632so30697001cf.3
        for <linux-aspeed@lists.ozlabs.org>; Fri, 19 Dec 2025 04:13:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766146400; x=1766751200; darn=lists.ozlabs.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z2sMzTB/9S9jACJVAZhu8V6NoQJ8NfstFRgn4YsuRPM=;
        b=hp7Vn0nruTyqRbYwTM0JvdUJTexZ5bYTseCoArC4jZ/jGt+YBDVPjFfG8nCaaSakBz
         Je8+PWlR9f+B2mUaSlOrKlDToOXrthVavs2k+8qYTTOJpXBJwDJ84HLoy0WEhIYXUjrN
         lniE5Y+mLlieJwMZXbBjyTUKauUosXlBMvCxvi8DSatYjsqYYN2S02kF0/xHCmt8L+IE
         bQbb/DJ+Dp/hXDEadMVyOh9XXnqdiYL3uzHUOt9ZLTctrxjBv/M/liHM40Ll5tb+Jlg0
         6k2iBGOJLvOsTbw5AlUtfzLmtzwiokJHxi77BmfFCGEwoua7imANgObXEUBrZ6XuEzUh
         4iuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766146400; x=1766751200;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z2sMzTB/9S9jACJVAZhu8V6NoQJ8NfstFRgn4YsuRPM=;
        b=ec9RPmHSpw1cSGIeIg2wf1B6OrVYyAJom1AjX7VOB4vUpLTmPXXUXHUtLmdv8jmeZh
         Xvi/jxCDKOwvkzYnVKbT4oGwXGp9LnTMRjdUYENV0VRx2/bcC77OVNyFFRm/xWqEZKwL
         uiTmax/XMO3kqK5ak6Lq9dj1NgJsvOrNG0NPmlI2LArKnIHtWXd0RWukhxeCRXN9lGMG
         sJ6O+13J6LVkwGSb5314iS9Gnz1JUwPPNZPTRY9sZpH8GMb4eWOJx1sQldUXUGWqhT21
         3n3KOZXAAjBD/zQ/XcMt2QHQu4yGbtm1smnRqAWzkkgdglw/OpYawc6i5sbXD3us8cMQ
         okHw==
X-Forwarded-Encrypted: i=1; AJvYcCUm1Ro0+39brVe2DkV8hbalEPWgzVNjqfUnCBE0gy/dVsXV39duSBlyPhlwL2bi5tQQYIhE27kCm3NWPjs=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyeTObSPbtpCTPBjFH/MeAuOjfI7lg3g3iyykXzsjGTFqMjbBaT
	s5dqlIVyvZbn80do9rEG055t0VBEAoifpLNMo2AmuOjTyxgzunLOQ4fr73bSaDm9Rr6vCYQnVIA
	BUldvYqRv3jlVYwekdz9AhOygNkgW3ar80O5oG7OuU88EZ/mW4oArl4W9acb5VK9IE/4s
X-Gm-Gg: AY/fxX5uv5pMcYz18yYn4+JRZkWboo+qmdepAjE3+8u6YKrUzO5gjbYooXQ9U86dtOF
	9Hob49DE6iUzziZFM8QXBN4I6WV/kfcFu5U5Opfl3N9uqk+zynYJWZKEvCqe1GBZ0t7OeMyewy0
	w0sz517aM8w6jEcHztzKnIed2mnO2e9akneC230zE9rPwK23/c+121FvTmmQPtDNaKtbgPCk5w7
	87KvPxQKjUUulXalUkF9k7sj+63RDt3V22U7RPEUAebFnWZS3hT3gnCukIVnapCCF3iywr+sNv5
	kQNaNWemk0gttIn8TMxduNHUS5z1MY6kJ8/w8DOEJzYcG0o1zsKeKGUXDxVICbfzllKCA+Usmyz
	+MqxE281KlVLKug9UHacuJlkfwSc+FBrY4RVD7TePn1XIi+aPzRvlL+gLmZ9ETgidhZ3Y
X-Received: by 2002:a05:622a:2610:b0:4f3:4cde:1660 with SMTP id d75a77b69052e-4f4abde3adbmr36402991cf.83.1766146400032;
        Fri, 19 Dec 2025 04:13:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IERo/Ph6jiM+hTOtV2Dbe7tgk55zLTZeLf6OTGFkErFMueI5t7pnJZbd6eZydQNrO7sGnAu6Q==
X-Received: by 2002:a05:622a:2610:b0:4f3:4cde:1660 with SMTP id d75a77b69052e-4f4abde3adbmr36402541cf.83.1766146399533;
        Fri, 19 Dec 2025 04:13:19 -0800 (PST)
Received: from [127.0.1.1] (83.31.98.88.ipv4.supernova.orange.pl. [83.31.98.88])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037f48606sm220309466b.62.2025.12.19.04.13.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Dec 2025 04:13:19 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v3 0/3] gpio: Simplify with device_get_match_data()
Date: Fri, 19 Dec 2025 13:13:11 +0100
Message-Id: <20251219-gpio-of-match-v3-0-6b84194a02a8@oss.qualcomm.com>
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
X-B4-Tracking: v=1; b=H4sIAFdBRWkC/3WMwQqDMBAFf6XsuZFsYiztyf8oHuIaNaDGJja0i
 P/e6KVQ6OXBPJhZIRhvTYDbaQVvog3WTQnk+QTU66kzzDaJQXChEHnButk65lo26oV6JmQtcmq
 alhcSkjN709rX0btXiXsbFuffRz7i/v4rRWScKU4XRKV5rkw52El7lznfwZ6K4qsLvP7qYtepU
 FTXCqWm0oWQPZ56IDeOWRqotm37ALnb/DfwAAAA
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1312;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=o9Jv/NWCSX0lI1ltggb7kobdggWkS+H54pSOi5S7iDA=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpRUFaRqV/DUlMw8fX+TWIjWGlMWLDl+PLXbJWM
 PI8W6v81kOJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaUVBWgAKCRDBN2bmhouD
 1wHSD/4laLKLg1mpSVorDo7erTjdp2WHh38g0Vj0eIyj24YNgOJdUk0qoUTsKrCB0nY6WINjASI
 CAGRWtIt1WrGc3bOyeBHMGG+dtZVvlg6kWZCoPJVhQ2IJqHV/qA8tp2uCmbIhOVe3lcPli7HwJX
 kPa98jcYg4jRCh+icpj2vcsxhV28Xq/NYvK2XV1Q5hN7JqUIbK/V70ai7Et9lFdA0RxswBfknxk
 hti/IbEXwBlS29fnehogQ3qbFEG8h3Dj872idkVkje8t+WL5T7/Q+gb+SlvTHQa4qTzdBaNbRYo
 w0XchMTB6ZWlvlxGWxy5QwLAVhYbyH0raZM1S0tTLjZEvvVc3IVNshMXJ9w0ZIkqYOxs+1HhHcL
 WrrRfpUvz3eH5+/PWk7au0E23m4XULDvTb3LgU+5Xdcbk2YTh+5QIZQrpkZwvFcBpd3TWXb+Okg
 Mfibq375CJGIHEoJkORfMstfHKI0hIEGr2VK4q5O44Ui4120w0pKBDun4IHp8z9nTUr14UcbnxF
 kTUW45m8bkrDt4Uui9xMgLJHCYmrlUt2Q/Oe0nKNTcoda6M2D0z++AgnP+wCR7uBAvHy4ldTOEJ
 f1qVGoKqbvBkKBbQ/V+EvEg6jQLj+EGQAOFVORKS1EYQQvj1IFwxZZ6lXxtgQ4SDuh06alQRmus
 ZPG4JowMyTN4Dxw==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Proofpoint-ORIG-GUID: TVkNMagqB-Vwdcqqq-sadUHPrj99av4D
X-Authority-Analysis: v=2.4 cv=A7ph/qWG c=1 sm=1 tr=0 ts=69454160 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=qe4J/qXhiWkb1JZGYKbLYA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8
 a=g6xpqFGyBtyTyoyyarcA:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
 a=FO4_E8m0qiDe52t0p3_H:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: TVkNMagqB-Vwdcqqq-sadUHPrj99av4D
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE5MDEwMSBTYWx0ZWRfX5c/89tbPXt5I
 hENxGXTgz6DTwGkRcToTpLNRtqUZG+RiP1+0wtjH+CWWV736WMI/fPqekt1d1BXULSexujhmN/a
 Smjcu+oLBdRuXEkNklVqmV8hw3KaXJldeAUYMbC0WQli2V2JuBqO7P3mHyHFpNiCBKHeIAxUJow
 ctcK1vpZtal3Ocf6bx8KreIcGKwwxgYqI1F7wuL5uRWuQJoq3qC+c8YusSjtFwuu3LHLMNE13iw
 kVOT3oSPkdwdenW6gN/h4zHsuNF7Bq0+nLY4HtifUi3ymWdpe6UGFh5+GqhSi4Q16ertqlStF+4
 mV28aG6CxHfcV7EWqEx2ITOQn8/Qq3i7dCH54TQcquTXMhk4LcZv7+1v+0bcalCPAM2Bowqbmey
 OgCmNjht3nR3BnzVk6KmVxD0CDOLqb7dKONeRFMZkLs1NqGHHFf/H1uJ0tCwRo9h4TqpsICTzRv
 1A+QHuEU13KKadEw58w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-19_03,2025-12-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 impostorscore=0 spamscore=0
 phishscore=0 suspectscore=0 malwarescore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512190101

Changes in v3:
- Fix subjects and commit msg -> device_get_match_data
- Patch #3: Use dev_err_probe
- Link to v2: https://patch.msgid.link/20251219-gpio-of-match-v2-0-5c65cbb513ac@oss.qualcomm.com

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
      gpio: aspeed: Simplify with device_get_match_data()
      gpio: creg-snps: Simplify with device_get_match_data()
      gpio: zynq: Simplify with device_get_match_data()

 drivers/gpio/gpio-aspeed.c    |  7 ++-----
 drivers/gpio/gpio-creg-snps.c |  4 +---
 drivers/gpio/gpio-zynq.c      | 12 +++++-------
 3 files changed, 8 insertions(+), 15 deletions(-)
---
base-commit: 26ac2c4153a2c543a4ef3dee421b46bedb0f8f0f
change-id: 20251106-gpio-of-match-23b24cddf063

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>


