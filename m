From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 11 Nov 2022 10:23:48 +0100
Subject: [PATCH] MAINTAINERS: aspeed: Update git tree URL
In-Reply-To: <CACPK8XdkXaVXzabFM-g6xQ1CBjZheiP9oFrYk5o1__QR7WBcdw@mail.gmail.com>
References: <20221110013438.16212-1-zev@bewilderbeest.net>
 <CACPK8XdkXaVXzabFM-g6xQ1CBjZheiP9oFrYk5o1__QR7WBcdw@mail.gmail.com>
Message-ID: <115eb408-1c59-49d6-9fca-c7b56431f472@app.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Nov 11, 2022, at 06:58, Joel Stanley wrote:
> On Thu, 10 Nov 2022 at 01:34, Zev Weiss <zev@bewilderbeest.net> wrote:
>>
>> The description for joel/aspeed.git on git.kernel.org currently says:
>>
>>     Old Aspeed tree. Please see joel/bmc.git
>>
>> Let's update MAINTAINERS accordingly.
>>
>> Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
>
> Thanks!
>
> Acked-by: Joel Stanley <joel@jms.id.au>
>
> Arnd, does the soc team have a branch for these?
>

I usually treat updates to the MAITNAINERS file as bugfixes and
merge them for the current release, as there is generally no risk
of regressions, and it's better to have up-to-date information
in the release kernel.

      Arnd
