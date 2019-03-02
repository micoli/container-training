<?php

namespace App\Command;

use App\Entities\Ball;
use App\Entities\Player;
use App\Entities\StadiumInterface;
use Symfony\Bundle\FrameworkBundle\Command\ContainerAwareCommand;
use Symfony\Component\Console\Input\InputInterface;
use Symfony\Component\Console\Output\OutputInterface;

class RunCommand extends ContainerAwareCommand
{
    protected function configure()
    {
        $this
            ->setName('application:command')
            ->setDescription('a command');
    }

    protected function execute(InputInterface $input, OutputInterface $output)
    {
        $output->writ();
    }
}

